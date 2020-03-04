import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/attention_seekers/bounce.dart';

enum AnimationType {
  Bounce,
  Flash,
  HeadShake,
  HeartBeat,
  Jello,
  Pulse,
  RubberBand,
  Shake,
  Swing,
  Tada,
  Wobble,
  BounceIn,
  BounceInDown,
  BounceInLeft,
  BounceInRight,
  BounceInUp,
  BounceOut,
  BounceOutDown,
  BounceOutLeft,
  BounceOutRight,
  BounceOutUp,
  FadeIn,
  FadeInDown,
  FadeInDownBig,
  FadeInLeft,
  FadeInLeftBig,
  FadeInRight,
  FadeInRightBig,
  FadeInUp,
  FadeInUpBig,
  FadeOut,
  FadeOutDown,
  FadeOutDownBig,
  FadeOutLeft,
  FadeOutLeftBig,
  FadeOutRight,
  FadeOutRightBig,
  FadeOutUp,
  FadeOutUpBig,
  Flip,
  FlipInX,
  FlipInY,
  FlipOutX,
  FlipOutY,
  LightSpeedIn,
  LightSpeedOut,
  RotateIn,
  RotateInDownLeft,
  RotateInDownRight,
  RotateInUpLeft,
  RotateInUpRight,
  RotateOut,
  RotateOutDownLeft,
  RotateOutDownRight,
  RotateOutUpLeft,
  RotateOutUpRight,
  SlideInDown,
  SlideInLeft,
  SlideInRight,
  SlideInUp,
  SlideOutDown,
  SlideOutLeft,
  SlideOutRight,
  SlideOutUp,
  Hinge,
  JackInTheBox,
  RollIn,
  RollOut,
  ZoomIn,
  ZoomInDown,
  ZoomInLeft,
  ZoomInRight,
  ZoomInUp,
  ZoomOut,
  ZoomOutDown,
  ZoomOutLeft,
  ZoomOutRight,
  ZoomOutUp,
}

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Animator Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AnimationType _type = AnimationType.Bounce;
  GlobalKey<AnimatorWidgetState> _key = GlobalKey<AnimatorWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: renderAnimation(),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DropdownButton<AnimationType>(
                  value: _type,
                  items: AnimationType.values
                      .map((e) => DropdownMenuItem<AnimationType>(
                            value: e,
                            child: Text(
                              e.toString().substring(14),
                              textAlign: TextAlign.center,
                            ),
                          ))
                      .toList(),
                  onChanged: (AnimationType value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.green,
                  ),
                  onPressed: () => _key.currentState.forward(),
                ),
              ],
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget renderAnimation() {
    final child = Text(
      _type.toString().substring(14),
      style: TextStyle(fontSize: 50),
    );
    switch (_type) {
      case AnimationType.Bounce:
        return Bounce(
          key: _key,
          child: child,
        );
      case AnimationType.Flash:
        return Flash(
          key: _key,
          child: child,
        );
      case AnimationType.HeadShake:
        return HeadShake(
          key: _key,
          child: child,
        );
      case AnimationType.HeartBeat:
        return HeartBeat(
          key: _key,
          child: child,
        );
      case AnimationType.Jello:
        return Jello(
          key: _key,
          child: child,
        );
      case AnimationType.Pulse:
        return Pulse(
          key: _key,
          child: child,
        );
      case AnimationType.RubberBand:
        return RubberBand(
          key: _key,
          child: child,
        );
      case AnimationType.Shake:
        return Shake(
          key: _key,
          child: child,
        );
      case AnimationType.Swing:
        return Swing(
          key: _key,
          child: child,
        );
      case AnimationType.Tada:
        return Tada(
          key: _key,
          child: child,
        );
      case AnimationType.Wobble:
        return Wobble(
          key: _key,
          child: child,
        );
      case AnimationType.BounceIn:
        return BounceIn(
          key: _key,
          child: child,
        );
      case AnimationType.BounceInDown:
        return BounceInDown(
          key: _key,
          child: child,
        );
      case AnimationType.BounceInLeft:
        return BounceInLeft(
          key: _key,
          child: child,
        );
      case AnimationType.BounceInRight:
        return BounceInRight(
          key: _key,
          child: child,
        );
      case AnimationType.BounceInUp:
        return BounceInUp(
          key: _key,
          child: child,
        );
      case AnimationType.BounceOut:
        return BounceOut(
          key: _key,
          child: child,
        );
      case AnimationType.BounceOutDown:
        return BounceOutDown(
          key: _key,
          child: child,
        );
      case AnimationType.BounceOutLeft:
        return BounceOutLeft(
          key: _key,
          child: child,
        );
      case AnimationType.BounceOutRight:
        return BounceOutRight(
          key: _key,
          child: child,
        );
      case AnimationType.BounceOutUp:
        return BounceOutUp(
          key: _key,
          child: child,
        );
      case AnimationType.FadeIn:
        return FadeIn(
          key: _key,
          child: child,
        );
      case AnimationType.FadeInDown:
        return FadeInDown(
          key: _key,
          child: child,
        );
      case AnimationType.FadeInDownBig:
        return FadeInDownBig(
          key: _key,
          child: child,
        );
      case AnimationType.FadeInLeft:
        return FadeInLeft(
          key: _key,
          child: child,
        );
      case AnimationType.FadeInLeftBig:
        return FadeInLeftBig(
          key: _key,
          child: child,
        );
      case AnimationType.FadeInRight:
        return FadeInRight(
          key: _key,
          child: child,
        );
      case AnimationType.FadeInRightBig:
        return FadeInRightBig(
          key: _key,
          child: child,
        );
      case AnimationType.FadeInUp:
        return FadeInUp(
          key: _key,
          child: child,
        );
      case AnimationType.FadeInUpBig:
        return FadeInUpBig(
          key: _key,
          child: child,
        );
      case AnimationType.FadeOut:
        return FadeOut(
          key: _key,
          child: child,
        );
      case AnimationType.FadeOutDown:
        return FadeOutDown(
          key: _key,
          child: child,
        );
      case AnimationType.FadeOutDownBig:
        return FadeOutDownBig(
          key: _key,
          child: child,
        );
      case AnimationType.FadeOutLeft:
        return FadeOutLeft(
          key: _key,
          child: child,
        );
      case AnimationType.FadeOutLeftBig:
        return FadeOutLeftBig(
          key: _key,
          child: child,
        );
      case AnimationType.FadeOutRight:
        return FadeOutRight(
          key: _key,
          child: child,
        );
      case AnimationType.FadeOutRightBig:
        return FadeOutRightBig(
          key: _key,
          child: child,
        );
      case AnimationType.FadeOutUp:
        return FadeOutUp(
          key: _key,
          child: child,
        );
      case AnimationType.FadeOutUpBig:
        return FadeOutUpBig(
          key: _key,
          child: child,
        );
      case AnimationType.Flip:
        return Flip(
          key: _key,
          child: child,
        );
      case AnimationType.FlipInX:
        return FlipInX(
          key: _key,
          child: child,
        );
      case AnimationType.FlipInY:
        return FlipInY(
          key: _key,
          child: child,
        );
      case AnimationType.FlipOutX:
        return FlipOutX(
          key: _key,
          child: child,
        );
      case AnimationType.FlipOutY:
        return FlipOutY(
          key: _key,
          child: child,
        );
      case AnimationType.LightSpeedIn:
        return LightSpeedIn(
          key: _key,
          child: child,
        );
      case AnimationType.LightSpeedOut:
        return LightSpeedOut(
          key: _key,
          child: child,
        );
      case AnimationType.RotateIn:
        return RotateIn(
          key: _key,
          child: child,
        );
      case AnimationType.RotateInDownLeft:
        return RotateInDownLeft(
          key: _key,
          child: child,
        );
      case AnimationType.RotateInDownRight:
        return RotateInDownRight(
          key: _key,
          child: child,
        );
      case AnimationType.RotateInUpLeft:
        return RotateInUpLeft(
          key: _key,
          child: child,
        );
      case AnimationType.RotateInUpRight:
        return RotateInUpRight(
          key: _key,
          child: child,
        );
      case AnimationType.RotateOut:
        return RotateOut(
          key: _key,
          child: child,
        );
      case AnimationType.RotateOutDownLeft:
        return RotateOutDownLeft(
          key: _key,
          child: child,
        );
      case AnimationType.RotateOutDownRight:
        return RotateOutDownRight(
          key: _key,
          child: child,
        );
      case AnimationType.RotateOutUpLeft:
        return RotateOutUpLeft(
          key: _key,
          child: child,
        );
      case AnimationType.RotateOutUpRight:
        return RotateOutUpRight(
          key: _key,
          child: child,
        );
      case AnimationType.SlideInDown:
        return SlideInDown(
          key: _key,
          child: child,
        );
      case AnimationType.SlideInLeft:
        return SlideInLeft(
          key: _key,
          child: child,
        );
      case AnimationType.SlideInRight:
        return SlideInRight(
          key: _key,
          child: child,
        );
      case AnimationType.SlideInUp:
        return SlideInUp(
          key: _key,
          child: child,
        );
      case AnimationType.SlideOutDown:
        return SlideOutDown(
          key: _key,
          child: child,
        );
      case AnimationType.SlideOutLeft:
        return SlideOutLeft(
          key: _key,
          child: child,
        );
      case AnimationType.SlideOutRight:
        return SlideOutRight(
          key: _key,
          child: child,
        );
      case AnimationType.SlideOutUp:
        return SlideOutUp(
          key: _key,
          child: child,
        );
      case AnimationType.Hinge:
        return Hinge(
          key: _key,
          child: child,
        );
      case AnimationType.JackInTheBox:
        return JackInTheBox(
          key: _key,
          child: child,
        );
      case AnimationType.RollIn:
        return RollIn(
          key: _key,
          child: child,
        );
      case AnimationType.RollOut:
        return RollOut(
          key: _key,
          child: child,
        );
      case AnimationType.ZoomIn:
        return ZoomIn(
          key: _key,
          child: child,
        );
      case AnimationType.ZoomInDown:
        return ZoomInDown(
          key: _key,
          child: child,
        );
      case AnimationType.ZoomInLeft:
        return ZoomInLeft(
          key: _key,
          child: child,
        );
      case AnimationType.ZoomInRight:
        return ZoomInRight(
          key: _key,
          child: child,
        );
      case AnimationType.ZoomInUp:
        return ZoomInUp(
          key: _key,
          child: child,
        );
      case AnimationType.ZoomOut:
        return ZoomOut(
          key: _key,
          child: child,
        );
      case AnimationType.ZoomOutDown:
        return ZoomOutDown(
          key: _key,
          child: child,
        );
      case AnimationType.ZoomOutLeft:
        return ZoomOutLeft(
          key: _key,
          child: child,
        );
      case AnimationType.ZoomOutRight:
        return ZoomOutRight(
          key: _key,
          child: child,
        );
      case AnimationType.ZoomOutUp:
        return ZoomOutUp(
          key: _key,
          child: child,
        );
    }
    return child;
  }
}
