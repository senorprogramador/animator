/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2020 Sjoerd van den Berg
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'dart:math';

import 'package:vector_math/vector_math_64.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../utils/pair.dart';

///The [Animator] class is the heart of this library.
///It registers and converts [TweenList]s, creates and manages controllers, etc.
///
///To create a single animation, use the following code:
///
///```dart
///class YourWidget extends StatefulWidget {
///   @override
///   _YourWidgetState createState() => _YourWidgetState();
///}
///
///class _YourWidgetState extends State<YourWidget> with SingleAnimatorStateMixin {
///
///   @override
///     Widget build(BuildContext context) {
///       //Note that when implementing SingleAnimatorStateMixin, the animation variable
///       //will be the instance of Animator as returned in createAnimation
///       return FadeTransition(
///         opacity: animation.get("opacity"), //get the opacity animation object. (Use animation.get("opacity").value when using an AnimatedBuilder)
///         child: widget.child,
///       );
///     }
///   }
///
///   @override
///   Animator createAnimation() {
///     return Animator.sync(this) //initializes an Animator with this widget as tickerprovider
///         .at(offset: Duration.zero, duration: Duration(seconds: 1)) //set optional offset and duration for the list below
///         .add( //add an animation "opacity" using the offset and duration above
///           key: "opacity",
///           tweens: TweenList<double>(
///             [
///               TweenPercentage(percent: 0, value: 1.0),
///               TweenPercentage(percent: 100, value: 0.0),
///             ],
///           ),
///         )
///         .generate(); //finally, don't forget to call generate()
///   }
///}
///```
///
class Animator {
  ///Initializes and returns a new Animator instance, setting it's TickerProvider
  ///and autoPlay values. (method-chain)
  static Animator sync(TickerProvider vsync, {bool autoPlay = true}) {
    assert(
      vsync != null,
      'vsync cannot be null.',
    );
    return Animator._internal(vsync, autoPlay);
  }

  ///Sets the offset and duration for the succeeding .add() calls. (method-chain)
  Animator at({Duration offset = Duration.zero, @required Duration duration}) {
    assert(
      offset != null,
      'offset cannot be null.',
    );
    assert(
      duration != null,
      'duration cannot be null.',
    );
    _currentOffset = offset;
    _currentDuration = duration;
    return this;
  }

  ///Adds an animation under the supplied key, using the supplied TweenList
  ///and the offset and duration as set by the preceding .at() function call.
  ///(method-chain)
  Animator add({
    @required String key,
    @required TweenList tweens,
  }) {
    assert(
      key != null,
      'key cannot be null.',
    );
    assert(
      tweens != null,
      'tweens cannot be null.',
    );
    sequence[key] = tweens;

    tweens.offset = _currentOffset;
    tweens.duration = _currentDuration;

    return this;
  }

  ///Add an [AnimationStatusListener] to the controller of this Animator instance.
  Animator addStatusListener(AnimationStatusListener listener) {
    this._animationStatusListener = listener;
    if (_controllerInitialized) {
      _controller.addStatusListener(_animationStatusListener);
    }
    return this;
  }

  ///Calculates total duration and assigns it to all tweens in the sequence.
  ///Creates a controller and converts all tweens to animations and adds
  ///them to the controller.
  Animator generate() {
    ///Calculate total duration.
    duration = Duration(
        milliseconds: sequence.values
            .map((it) => it.offset.inMilliseconds + it.duration.inMilliseconds)
            .reduce((value, it) => max(value, it)));

    ///Assign total duration to sequence.
    sequence.values.forEach((it) => it.animationDuration = duration);

    _controller = AnimationController(
      duration: duration,
      vsync: _vsync,
    );

    if (_animationStatusListener != null) {
      _controller.addStatusListener(_animationStatusListener);
    }

    _addAnimationsToController();

    _controllerInitialized = true;
    return this;
  }

  ///Returns an [Animation] registered by the user in the .add() function.
  Animation get(String key) {
    assert(
      _controllerInitialized,
      'Controller not initialized, did you forget to call generate on '
      'Anim8tor.sync().add(...).generate()?',
    );
    if (!sequence.containsKey(key)) return null;
    return sequence[key].animation;
  }

  ///Map for holding the [TweenList]s
  Map<String, TweenList> sequence = {};

  ///The tickerProvider for an Animator instance
  final TickerProvider _vsync;

  ///Should it play it's animations automatically when created?
  final bool autoPlay;

  ///Holds the total duration of an Ani8or instance
  Duration duration;

  ///Optionally subscribe to [AnimationStatus] changes.
  AnimationStatusListener _animationStatusListener;

  ///The generated [AnimationController], driving the generated [Animation]s
  ///from the registered [TweenList]s
  AnimationController _controller;

  ///Whether the above _controller was initialized by a .generate() call
  bool _controllerInitialized = false;

  ///Getter for the controller to ensure .generate() was called properly.
  AnimationController get controller {
    assert(
      _controllerInitialized,
      'Animator.generate() must be called before accessing Animator.controller.',
    );

    return _controller;
  }

  ///Holder for the offset of animations set by .at() function
  Duration _currentOffset;

  ///Holder for the duration of animations set by .at() function
  Duration _currentDuration;

  ///Protected constructor (Use Animator.sync())
  Animator._internal(this._vsync, this.autoPlay);

  void dispose() {
    if (_controllerInitialized && _controller != null) {
      _controller.dispose();
      _controller = null;
      _controllerInitialized = false;
    }
  }

  ///Converts tweens to animations by animating them with the controller.
  _addAnimationsToController() {
    sequence.values.forEach((value) {
      value.animation = value.animate(_controller);
    });
    _controllerInitialized = true;
  }
}

///@section - Single Animation.
abstract class _AnimatorSingleAnimationProvider {
  Animator createAnimation();
}

///Use this mixin to generate a Single Animator instance Widget.
///createAnimation() is used to request a new Animator instance, it's value is
///bound to the animation variable.
mixin SingleAnimatorStateMixin<T extends StatefulWidget> on State<T>
    implements TickerProvider, _AnimatorSingleAnimationProvider {
  Animator animation;
  Ticker _ticker;

  @override
  void reassemble() {
    if (!kReleaseMode) {
      _disposeExistingAnimation();
      setState(() {
        animation = createAnimation();
      });
      if (animation.autoPlay) {
        animation.controller.forward(from: 0.0);
      }
    }
    super.reassemble();
  }

  @override
  void initState() {
    _disposeExistingAnimation();
    animation = createAnimation();
    if (animation.autoPlay) {
      animation.controller.forward(from: 0.0);
    }
    super.initState();
  }

  _disposeExistingAnimation() {
    if (animation != null) {
      animation.dispose();
    }
    if (_ticker != null) {
      _ticker.dispose();
      _ticker = null;
    }
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    _disposeExistingAnimation();

    _ticker =
        Ticker(onTick, debugLabel: kDebugMode ? 'created by $this' : null);
    return _ticker;
  }

  @override
  void dispose() {
    _disposeExistingAnimation();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_ticker != null) _ticker.muted = !TickerMode.of(context);
    super.didChangeDependencies();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    String tickerDescription;
    if (_ticker != null) {
      if (_ticker.isActive && _ticker.muted)
        tickerDescription = 'active but muted';
      else if (_ticker.isActive)
        tickerDescription = 'active';
      else if (_ticker.muted)
        tickerDescription = 'inactive and muted';
      else
        tickerDescription = 'inactive';
    }
    properties.add(DiagnosticsProperty<Ticker>('ticker', _ticker,
        description: tickerDescription,
        showSeparator: false,
        defaultValue: null));
  }
}

///@section - Multi Animation.
abstract class _AnimatorAnimationsProvider {
  Map<String, Animator> createAnimations();
}

mixin AnimatorStateMixin<T extends StatefulWidget> on State<T>
    implements TickerProvider, _AnimatorAnimationsProvider {
  Map<String, Animator> animations = {};
  Set<Ticker> _tickers = <Ticker>{};

  @override
  void reassemble() {
    if (!kReleaseMode) {
      _disposeExistingAnimations();
      setState(() {
        animations = createAnimations();
      });
      _autoPlay();
    }
    super.reassemble();
  }

  @override
  void initState() {
    _disposeExistingAnimations();
    animations = createAnimations();
    _autoPlay();
    super.initState();
  }

  void _autoPlay() {
    animations.values.forEach((it) {
      if (it.autoPlay) {
        it.controller.forward(from: 0.0);
      }
    });
  }

  _disposeExistingAnimations() {
    animations.values.forEach((it) => it.dispose());
    animations = {};
    _disposeTickers();
  }

  _disposeTickers() {
    _tickers.forEach((it) => it.dispose());
    _tickers = <Ticker>{};
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    final result =
        Ticker(onTick, debugLabel: kDebugMode ? 'created by $this' : null);
    _tickers.add(result);
    return result;
  }

  @override
  void dispose() {
    _disposeExistingAnimations();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _tickers.forEach((it) {
      it.muted = !TickerMode.of(context);
    });
    super.didChangeDependencies();
  }
}

///[TweenPercentage] is used by the the [TweenList], it defines a value and
///curve at a certain percentage of the animation.
class TweenPercentage<T> {
  final double percent;
  final T value;
  final Curve curve;

  TweenPercentage({
    @required this.percent,
    @required this.value,
    this.curve = Curves.ease,
  });
}

///[TweenList] is a [Tween] which contains a list of [TweenPercentage]s to
///enable users to efficiently define a multi-curved animation with multiple
///value-blends.
///Please note that although Matrix4 tweens are supported, the tend to be a bit
///slower, due to the Matrix decomposition
class TweenList<T extends dynamic> extends Tween<T> {
  List<TweenPercentage<T>> _values;
  Duration offset;
  Duration duration;
  Pair<TweenPercentage<T>, TweenPercentage<T>> _pair;

  set animationDuration(Duration value) {
    beginT = offset.inMilliseconds.toDouble() / value.inMilliseconds.toDouble();
    endT = (offset.inMilliseconds + duration.inMilliseconds).toDouble() /
        value.inMilliseconds.toDouble();
  }

  double beginT;
  double endT;
  Animation<T> animation;

  TweenList(List<TweenPercentage<T>> values,
      {this.offset = Duration.zero, this.duration}) {
    _values = values;
    _values.sort((a, b) => a.percent.compareTo(b.percent));
  }

  Pair<TweenPercentage<T>, TweenPercentage<T>> fetchFromTo(double t) {
    final a = _values.reversed.firstWhere(
        (element) => element.percent < t * 100.0,
        orElse: () => _values.first);
    final b = _values.firstWhere((element) => element.percent >= t * 100.0,
        orElse: () => _values.last);
    return Pair(a, b);
  }

  @override
  T transform(double t) {
    return lerp(t);
  }

  Quaternion qlerp(Quaternion qa, Quaternion qb, double t2) {
    Quaternion qm;
    double t1 = 1.0 - t2;
    qm = qa.scaled(t1) + qb.scaled(t2);
    double len = sqrt(qm.x * qm.x + qm.y * qm.y + qm.z * qm.z + qm.w * qm.w);
    qm.scale(1.0 - len);
    return qm;
  }

  @override
  T lerp(double t) {
    double nt = (t - beginT) / (endT - beginT);

    if (nt == 0.0) {
      return _values.first.value;
    }
    if (nt == 1.0) {
      return _values.last.value;
    }

    if (_pair == null ||
        _pair.b.percent < nt * 100.0 ||
        _pair.a.percent > nt * 100.0) {
      _pair = fetchFromTo(nt);
    }

    if (nt * 100.0 < _pair.a.percent) {
      return _pair.a.value;
    }
    if (nt * 100.0 > _pair.b.percent) {
      return _pair.b.value;
    }

    final n = _pair.a.curve.transform(
        (nt * 100.0 - _pair.a.percent) / (_pair.b.percent - _pair.a.percent));

    if (T == Matrix4) {
      final Vector3 beginTranslation = Vector3.zero();
      final Vector3 endTranslation = Vector3.zero();
      final Quaternion beginRotation = Quaternion.identity();
      final Quaternion endRotation = Quaternion.identity();
      final Vector3 beginScale = Vector3.zero();
      final Vector3 endScale = Vector3.zero();

      _pair.a.value.decompose(beginTranslation, beginRotation, beginScale);
      _pair.b.value.decompose(endTranslation, endRotation, endScale);

      final Vector3 lerpTranslation =
          beginTranslation * (1.0 - n) + endTranslation * n;
      final Quaternion lerpRotation =
          qlerp(beginRotation, endRotation, n).normalized();
      final Vector3 lerpScale = beginScale * (1.0 - n) + endScale * n;

      return Matrix4.compose(lerpTranslation, lerpRotation, lerpScale) as T;
    }

    return _pair.a.value + n * (_pair.b.value - _pair.a.value) as T;
  }
}
