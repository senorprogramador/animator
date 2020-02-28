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
import '../../utils/animator.dart';

class FadeOutRight extends StatefulWidget {
  final Widget child;
  final Duration offset;
  final Duration duration;
  final AnimationStatusListener animationStatusListener;

  FadeOutRight({
    @required this.child,
    this.offset = Duration.zero,
    this.duration = const Duration(seconds: 1),
    this.animationStatusListener,
  }) {
    assert(child != null, 'Error: child in $this cannot be null');
    assert(offset != null, 'Error: offset in $this cannot be null');
    assert(duration != null, 'Error: duration in $this cannot be null');
  }

  @override
  _FadeOutRightState createState() => _FadeOutRightState();
}

class _FadeOutRightState extends State<FadeOutRight> {
  Size size;
  GlobalKey _key = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _key.currentContext.findRenderObject();
      setState(() {
        size = renderBox.size;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (size == null) {
      return Container(key: _key, child: widget.child);
    }
    return _FadeOutRightAnimation(
      child: widget.child,
      size: size,
      offset: widget.offset,
      duration: widget.duration,
      animationStatusListener: widget.animationStatusListener,
    );
  }
}

class _FadeOutRightAnimation extends StatefulWidget {
  final Widget child;
  final Size size;
  final Duration offset;
  final Duration duration;
  final AnimationStatusListener animationStatusListener;

  _FadeOutRightAnimation({
    @required this.child,
    @required this.size,
    this.offset = Duration.zero,
    this.duration = const Duration(seconds: 1),
    this.animationStatusListener,
  }) {
    assert(child != null, 'Error: child in $this cannot be null');
    assert(offset != null, 'Error: offset in $this cannot be null');
    assert(duration != null, 'Error: duration in $this cannot be null');
  }

  @override
  __FadeOutRightAnimationState createState() => __FadeOutRightAnimationState();
}

class __FadeOutRightAnimationState extends State<_FadeOutRightAnimation>
    with SingleAnimatorStateMixin {
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation.get("opacity"),
      child: AnimatedBuilder(
        animation: animation.controller,
        child: widget.child,
        builder: (BuildContext context, Widget child) => Transform.translate(
          child: child,
          offset: Offset(animation.get("translateX").value, 0.0),
        ),
      ),
    );
  }

  @override
  Animator createAnimation() {
    return Animator.sync(this)
        .at(offset: widget.offset, duration: widget.duration)
        .add(
          key: "opacity",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 1.0),
              TweenPercentage(percent: 100, value: 0.0),
            ],
          ),
        )
        .add(
          key: "translateX",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.0),
              TweenPercentage(percent: 100, value: widget.size.width),
            ],
          ),
        )
        .addStatusListener(widget.animationStatusListener)
        .generate();
  }
}
