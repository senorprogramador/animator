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

class BounceIn extends StatefulWidget {
  final Widget child;
  final Duration offset;
  final Duration duration;
  final AnimationStatusListener animationStatusListener;

  BounceIn({
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
  _BounceInState createState() => _BounceInState();
}

class _BounceInState extends State<BounceIn> with SingleAnimatorStateMixin {
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation.get("opacity"),
      child: AnimatedBuilder(
        animation: animation.controller,
        child: widget.child,
        builder: (BuildContext context, Widget child) => Transform.scale(
          child: child,
          scale: animation.get("scale").value,
          alignment: new FractionalOffset(0.5, 0.5),
        ),
      ),
    );
  }

  @override
  Animator createAnimation() {
    final curve = Cubic(0.215, 0.61, 0.355, 1);
    return Animator.sync(this)
        .at(offset: widget.offset, duration: widget.duration)
        .add(
          key: "opacity",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.0, curve: curve),
              TweenPercentage(percent: 60, value: 1.0, curve: curve),
            ],
          ),
        )
        .add(
          key: "scale",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.3, curve: curve),
              TweenPercentage(percent: 20, value: 1.1, curve: curve),
              TweenPercentage(percent: 40, value: 0.9, curve: curve),
              TweenPercentage(percent: 60, value: 1.03, curve: curve),
              TweenPercentage(percent: 80, value: 0.97, curve: curve),
              TweenPercentage(percent: 100, value: 1.0),
            ],
          ),
        )
        .addStatusListener(widget.animationStatusListener)
        .generate();
  }
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
