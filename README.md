# animator

Enables you to create stunning flutter animations, faster, efficient and with less code.

Partly inspired by the amazing [Animate.css](https://daneden.github.io/animate.css/) package by Dan Eden.

Features:
- Combine and chain Tweens with multiple easing-curves.
- Less boilerplate code by using a mixin which directly provides the controller, animations etc.
- Automatically (re)starts animations on hot-reload after saving.
- Animate your project with ease using the Animate.css based Widgets.

## Getting Started
_Note: To see all of the animated widgets in action be sure to run the app in the example package, or view them on the [Animate.css](https://daneden.github.io/animate.css/) page._

Put the dependency inside your pubspec.yml and run packages get.

#### Using one of the Animate.css style widgets:
```dart
import 'package:flutter/widgets.dart';
import 'package:animator/animator.dart';

class TestAnimatedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RubberBand(
      child: Text(
        'Rubber',
        style: TextStyle(fontSize: 60),
      ),
    );
  }
}
```

#### Create your own:
Below is the code (with extra comments) from the actual Flash animated widget.
It should give you a clear insight on how to animate with the Animator.

```dart
import 'package:flutter/widgets.dart';
import 'package:animator/animator.dart';

class Flash extends StatefulWidget {
  final Widget child;
  final Duration offset;
  final Duration duration;
  final AnimationStatusListener animationStatusListener;

  Flash({
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
  _FlashState createState() => _FlashState();
}

class _FlashState extends State<Flash> with SingleAnimatorStateMixin { //<- implement SingleAnimatorStateMixin
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation.get("opacity"), //<- use "opacity" Animation as defined below in createAnimation()
      child: widget.child,
    );
  }

  @override
  Animator createAnimation() {
    return Animator.sync(this) //<- sync initializes a new Animator instance with this as TickerProvider
        .at(offset: widget.offset, duration: widget.duration) //<- use at() to define offset and duration for animations below 
        .add(
          key: "opacity", //<- add "opacity" animation
          tweens: TweenList<double>( //<- create a blended tween of double values
            [
              TweenPercentage(percent: 0, value: 1.0), //<- at 0 percent we want a value of 1.0
              TweenPercentage(percent: 25, value: 0.0),//<- at 25 percent we want a value of 0.0, etc.
              TweenPercentage(percent: 50, value: 1.0),
              TweenPercentage(percent: 75, value: 0.0), // Note that it's also possible to assign a curve here.
              TweenPercentage(percent: 100, value: 1.0),
            ],
          ),
        )
        .addStatusListener(widget.animationStatusListener)
        .generate(); //<- Generate must always be called at the end, to generate the AnimationController.
  }
}
```
#### Chaining animations
You can chain animations in the following manner:
```dart
Animator.sync(this)
  .at(duration: Duration(seconds: 1))
  .add(...)
  .add(...)//<- Add multiple animations from 0 to 1 seconds
  .at(offset: Duration(seconds: 1), duration: Duration(seconds: 1))
  .add(...)
  .add(...)//<- Add multiple animations from 1 to 2 seconds
  .generate();
```
