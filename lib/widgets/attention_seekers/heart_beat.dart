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

class HeartBeat extends StatefulWidget {
  final Widget child;
  final Duration offset;
  final Duration duration;
  final AnimationStatusListener animationStatusListener;

  HeartBeat({
    @required this.child,
    this.offset = Duration.zero,
    this.duration = const Duration(milliseconds: 1300),
    this.animationStatusListener,
  }) {
    assert(child != null, 'Error: child in $this cannot be null');
    assert(offset != null, 'Error: offset in $this cannot be null');
    assert(duration != null, 'Error: duration in $this cannot be null');
  }

  @override
  _HeartBeatState createState() => _HeartBeatState();
}

class _HeartBeatState extends State<HeartBeat> with SingleAnimatorStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation.controller,
      child: widget.child,
      builder: (BuildContext context, Widget child) => Transform.scale(
        child: child,
        scale: animation.get("scale").value,
        alignment: Alignment.center,
      ),
    );
  }

  @override
  Animator createAnimation() {
    final curve = Curves.easeInOut;
    return Animator.sync(this)
        .at(offset: widget.offset, duration: widget.duration)
        .add(
          key: "scale",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 1.0, curve: curve),
              TweenPercentage(percent: 14, value: 1.3, curve: curve),
              TweenPercentage(percent: 28, value: 1.0, curve: curve),
              TweenPercentage(percent: 42, value: 1.3, curve: curve),
              TweenPercentage(percent: 70, value: 1.0, curve: curve),
            ],
          ),
        )
        .addStatusListener(widget.animationStatusListener)
        .generate();
  }
}
