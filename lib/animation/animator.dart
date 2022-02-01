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

import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

///The [Animator] class is the heart of this library.
///It registers and converts [TweenList]s, creates and manages controllers, etc.
///
///To create an animation, please see [AnimatorWidget] and [AnimationDefinition]
///classes for a description.
class Animator {
  ///The tickerProvider for an Animator instance
  final TickerProvider vsync;

  ///The defined animation
  late AnimationDefinition _definition;

  ///Map for holding the [TweenList]s
  late Map<String, TweenList> _sequence;

  ///Thee generated [AnimationController]
  AnimationController? _controller;

  ///Getter for the [AnimationController]
  AnimationController? get controller => _controller;

  ///constructor, requires a [TickerProvider]
  Animator({required this.vsync});

  ///Loop an animation. Pass pingPong to loop forward and reversed.
  void loop({bool pingPong = false}) {
    if (_controller != null) {
      _controller!.repeat(reverse: pingPong);
    }
  }

  ///Plays the animation forward from passed parameter.
  void forward({double from = 0.0}) {
    if (_controller != null) {
      _controller!.forward(from: from);
    }
  }

  ///Plays the animation backwards from passed parameter.
  void reverse({double from = 1.0}) {
    if (_controller != null) {
      _controller!.reverse(from: from);
    }
  }

  ///Pauses the animation.
  void stop() {
    if (_controller != null) {
      _controller!.stop();
    }
  }

  ///Rewinds and stops the animation.
  void reset() {
    if (_controller != null) {
      _controller!.reset();
    }
  }

  ///Sets the [AnimationDefinition] to be used for creating a controller.
  void setAnimationDefinition(AnimationDefinition definition) {
    _definition = definition;
  }

  ///Resolves the [AnimationDefinition], creates a controller and sets offset
  ///and duration from the passed in [AnimationPreferences].
  ///If needsWidgetSize and/or needsScreenSize are true inside the definition
  ///these will be passed to the [AnimationDefinition]
  void resolveDefinition({Size? widgetSize, Size? screenSize}) {
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
      value.animation = value.animate(_controller!);
    });

    if (_definition.preferences.animationStatusListener != null) {
      _controller!
          .addStatusListener(_definition.preferences.animationStatusListener!);
    }
  }

  ///Builds the [AnimationDefinition].
  Widget build(BuildContext context, Widget child) {
    return _definition.build(context, this, child);
  }

  ///Disposes the controller.
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
      _controller = null;
    }
  }

  ///Returns an [Animation] registered by the user in
  ///[AnimationDefinition].getDefinition() function.
  Animation? get(String key) {
    assert(
      _controller != null,
      '${this} _controller not initialized, did you forget to call resolveDefinition()?',
    );

    if (!_sequence.containsKey(key)) return null;
    return _sequence[key]!.animation;
  }
}
