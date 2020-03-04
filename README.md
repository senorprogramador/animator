# animator

Enables you to create stunning flutter animations, faster, efficient and with less code.

Partly inspired by the amazing [Animate.css](https://daneden.github.io/animate.css/) package by Dan Eden.
Please note, that although it's inspired by Animate.css, this still is a Flutter package, meaning it will be available for all flutter-supported platforms

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

#### Using a GlobalKey to enable play/stop/reverse animations from code:
```dart
import 'package:flutter/widgets.dart';
import 'package:animator/animator.dart';

class TestAnimatedWidget extends StatefulWidget {
  @override
  _TestAnimatedWidgetState createState() => _TestAnimatedWidgetState();
}
class _TestAnimatedWidgetState extends State<TestAnimatedWidget> {
  //Register a key in your state:
  GlobalKey<AnimatorWidgetState> _key = GlobalKey<AnimatorWidgetState>();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            //Render the widget using the _key
            child: RubberBand(
              key: _key,
              child: Text(
                'Rubber',
                style: TextStyle(fontSize: 60),
              ),
            ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
            child: IconButton(
              icon: Icon(
                Icons.play_arrow,
                color: Colors.green,
              ),
              //Use _key.currentState to forward/stop/reverse
              onPressed: () => _key.currentState.forward(),
            ),
        ),
      ],
    );
  }
}
```

#### Create your own:
Below is the code (with extra comments) from the actual Flash animated widget.
It should give you a clear insight on how to animate with the Animator using the _AnimatorWidget_.

```dart
import 'package:flutter/widgets.dart';
import 'package:animator/animator.dart';

class Flash extends AnimatorWidget {
  Flash({
    Key key,
    @required Widget child,
    AnimatorPreferences prefs = const AnimatorPreferences(),
  }) : super(key: key, child: child, prefs: prefs);

  @override
  FlashState createState() => FlashState();
}

class FlashState extends AnimatorWidgetState<Flash> {
  @override
  Widget renderAnimation(BuildContext context) {
    return FadeTransition(
      opacity: animation.get("opacity"),
      child: widget.child,
    );
  }

  @override
  Animator createAnimation(Animator animation) {
    return animation
        .at(offset: widget.prefs.offset, duration: widget.prefs.duration)
        .add(
          key: "opacity",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 1.0),
              TweenPercentage(percent: 25, value: 0.0),
              TweenPercentage(percent: 50, value: 1.0),
              TweenPercentage(percent: 75, value: 0.0),
              TweenPercentage(percent: 100, value: 1.0),
            ],
          ),
        )
        .addStatusListener(widget.prefs.animationStatusListener);
  }
}
```
#### Use widget or screen size inside your animations
If you would like to use widget or screen size (or both)
You can enable this by initializing the _AnimatorWidget_ with _needsScreenSize: true_ and _needsWidgetSize: true_.
The widget will then expose the screenSize and/or widgetSize variables for you to use.
Please not that in both cases the widget will pre-render the child once to extract screen/widget- sizes.
This pre-rendering can lead to unwanted artifacts (in this case, an unwanted visible render) and can be resolved by overriding the ```double get preRenderOpacity => 1.0;``` and set it to ```0.0``` 
```dart
import 'package:vector_math/vector_math_64.dart' as Math;
import 'package:flutter/widgets.dart';
import 'package:animator/animator.dart';

class RollIn extends AnimatorWidget {
  RollIn({
    Key key,
    @required Widget child,
    AnimatorPreferences prefs = const AnimatorPreferences(),
  }) : super(key: key, child: child, prefs: prefs, needsWidgetSize: true);

  @override
  RollInState createState() => RollInState();
}

class RollInState extends AnimatorWidgetState<RollIn> {

  @override
  Widget renderAnimation(BuildContext context) {
    return FadeTransition(
      opacity: animation.get("opacity"),
      child: AnimatedBuilder(
        animation: animation.controller,
        child: widget.child,
        builder: (BuildContext context, Widget child) => Transform(
          child: child,
          transform: Matrix4.translationValues(
                  animation.get("translateX").value, 0.0, 0.0) *
              Matrix4.rotationZ(animation.get("rotateZ").value),
          alignment: Alignment.center,
        ),
      ),
    );
  }

  @override
  Animator createAnimation(Animator animation) {
    return animation
        .at(offset: widget.prefs.offset, duration: widget.prefs.duration)
        .add(
          key: "opacity",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.0),
              TweenPercentage(percent: 100, value: 1.0),
            ],
          ),
        )
        .add(
          key: "translateX",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: -widgetSize.width),
              TweenPercentage(percent: 100, value: 0.0),
            ],
          ),
        )
        .add(
          key: "rotateZ",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: Math.radians(-120.0)),
              TweenPercentage(percent: 100, value: 0.0),
            ],
          ),
        )
        .addStatusListener(widget.prefs.animationStatusListener);
  }
}
```

#### Chaining animations
You can chain animations in the following manner:
```dart
return animator
  .at(duration: Duration(seconds: 1))
  .add(...)
  .add(...)//<- Add multiple animations from 0 to 1 seconds
  .at(offset: Duration(seconds: 1), duration: Duration(seconds: 1))
  .add(...)
  .add(...);//<- Add multiple animations from 1 to 2 seconds
```

## Available default animations:
### Attention Seekers
![Attention Seekers](https://cloud.githubusercontent.com/assets/378279/10590307/ef73b1ba-767d-11e5-8fb9-9779d3a53a50.gif)
- Bounce
- Flash
- HeadShake
- HeartBeat
- Jello
- Pulse
- RubberBand
- Shake
- Swing
- Tada
- Wobble

### Bouncing Entrances
![Bouncing Entrances](https://cloud.githubusercontent.com/assets/378279/10590306/ef572bbc-767d-11e5-8440-8e61d401537a.gif)
- BounceIn
- BounceInDown
- BounceInLeft
- BounceInRight
- BounceInUp

### Bouncing Exits
![Bouncing Exits](https://cloud.githubusercontent.com/assets/378279/10590305/ef56e4cc-767d-11e5-9562-6cd3210faf34.gif)
- BounceOut
- BounceOutDown
- BounceOutLeft
- BounceOutRight
- BounceOutUp

### Fading Entrances
![Fading Entrances](https://cloud.githubusercontent.com/assets/378279/10590304/ef4f09b4-767d-11e5-9a43-06e97e8ee2c1.gif)
- FadeIn
- FadeInDown
- FadeInDownBig
- FadeInLeft
- FadeInLeftBig
- FadeInRight
- FadeInRightBig
- FadeInUp
- FadeInUpBig

### Fading Exits
![Fading Exits](https://cloud.githubusercontent.com/assets/378279/10590303/ef3e9598-767d-11e5-83bc-bd48d6017131.gif)
- FadeOut
- FadeOutDown
- FadeOutDownBig
- FadeOutLeft
- FadeOutLeftBig
- FadeOutRight
- FadeOutRightBig
- FadeOutUp
- FadeOutUpBig

### Flippers
![Flippers](https://cloud.githubusercontent.com/assets/378279/10590296/ef3076ca-767d-11e5-9f62-6b9c696dad51.gif)
- Flip
- FlipInX
- FlipInY
- FlipOutX
- FlipOutY

### Lightspeed
![Lightspeed](https://cloud.githubusercontent.com/assets/378279/10590301/ef374c8e-767d-11e5-83ad-b249d2731f43.gif)
- LightSpeedIn
- LightSpeedOut

### Rotating Entrances
No previews available.
- RotateIn
- RotateInDownLeft
- RotateInDownRight
- RotateInUpLeft
- RotateInUpRight

### Rotating Exits
No previews available.
- RotateOut
- RotateOutDownLeft
- RotateOutDownRight
- RotateOutUpLeft
- RotateOutUpRight

### Sliding Entrances
![Sliding Entrances](https://cloud.githubusercontent.com/assets/378279/10590300/ef36dfe2-767d-11e5-932b-1cccce78087b.gif)
- SlideInDown
- SlideInLeft
- SlideInRight
- SlideInUp

### Sliding Exits
![Sliding Exits](https://cloud.githubusercontent.com/assets/378279/10590299/ef35a3ca-767d-11e5-94e0-441fd49b6444.gif)
- SlideOutDown
- SlideOutLeft
- SlideOutRight
- SlideOutUp

### Specials
No previews available.
- Hinge
- JackInTheBox
- RollIn
- RollOut

### Zooming Entrances
![Zooming Entrances](https://cloud.githubusercontent.com/assets/378279/10590302/ef37d438-767d-11e5-8480-a212e21c2192.gif)
- ZoomIn
- ZoomInDown
- ZoomInLeft
- ZoomInRight
- ZoomInUp

### Zooming Exits
![Zooming Exits](https://cloud.githubusercontent.com/assets/378279/10590298/ef33fa52-767d-11e5-80fe-6b8dbb5e53d0.gif)
- ZoomOut
- ZoomOutDown
- ZoomOutLeft
- ZoomOutRight
- ZoomOutUp

#### Please press the like button if you like this package, or star it on github.