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

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

import 'animation_definition.dart';
import 'tween_list.dart';

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
  ///The tickerProvider for an Animator instance
  final TickerProvider vsync;

  ///The defined animation
  AnimationDefinition _definition;

  ///Map for holding the [TweenList]s
  Map<String, TweenList> _sequence;

  ///Thee generated [AnimationController]
  AnimationController _controller;
  AnimationController get controller => _controller;

  Animator({@required this.vsync}) {
    assert(
      vsync != null,
      '$this vsync cannot be null.',
    );
  }

  void loop({bool pingPong = false}) {
    if (_controller != null) {
      _controller.repeat(reverse: pingPong);
    }
  }

  void forward({double from = 0.0}) {
    if (_controller != null) {
      _controller.forward(from: from);
    }
  }

  void reverse({double from = 1.0}) {
    if (_controller != null) {
      _controller.reverse(from: from);
    }
  }

  void stop() {
    if (_controller != null) {
      _controller.stop();
    }
  }

  void setAnimationDefinition(AnimationDefinition definition) {
    _definition = definition;
  }

  void resolveDefinition({Size widgetSize, Size screenSize}) {
    _sequence = _definition.getDefinition(
      widgetSize: widgetSize,
      screenSize: screenSize,
    );

    _controller = AnimationController(
      duration:
          _definition.preferences.offset + _definition.preferences.duration,
      vsync: vsync,
    );

    _sequence.values.forEach((value) {
      value.offset = _definition.preferences.offset;
      value.duration =
          _definition.preferences.offset + _definition.preferences.duration;
      value.animation = value.animate(_controller);
    });

    if (_definition.preferences.animationStatusListener != null) {
      _controller
          .addStatusListener(_definition.preferences.animationStatusListener);
    }
  }

  Widget build(BuildContext context, Widget child) {
    return _definition.build(context, this, child);
  }

  void dispose() {
    if (_controller != null) {
      _controller.dispose();
      _controller = null;
    }
  }

  ///Returns an [Animation] registered by the user in the .add() function.
  Animation get(String key) {
    assert(
      _controller != null,
      '${this} _controller not initialized, did you forget to call resolveDefinition()?',
    );

    if (!_sequence.containsKey(key)) return null;
    return _sequence[key].animation;
  }
}
