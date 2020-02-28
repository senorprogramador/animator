# animator

Enables you to create stunning flutter animations, faster, efficient and with less code.

Partly inspired by the amazing [Animate.css](https://daneden.github.io/animate.css/) package by Dan Eden.

Features:
- Combine and chain Tweens with multiple easing-curves.
- Less boilerplate code by using a mixin which directly provides the controller, animations etc.
- Automatically (re)starts animations on hot-reload after saving.
- Animate your project with ease using the Animate.css based Widgets.

## Getting Started
_Note: To see al of the animated widgets in action be sure to run the app in the example package, or view them on the [Animate.css](https://daneden.github.io/animate.css/) page._

Put the dependency inside your pubspec.yml and run packages get.

#### Using one of the Animate.css style widgets:
```dart
import 'package:flutter/widgets.dart';
import 'package:animator/animator.dart';

class AnimatedWidget extends StatelessWidget {
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
