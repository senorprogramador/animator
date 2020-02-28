import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

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
  bool renderWidgets = true;

  @override
  Widget build(BuildContext context) {
    if (!renderWidgets) {
      Future.delayed(Duration.zero, () => setState(() { renderWidgets = true; }));
    }
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
              child: renderWidgets
                  ? renderAnimation()
                  : Padding(
                      padding: EdgeInsets.zero,
                    ),
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
                  onPressed: () => this.setState(() {
                    renderWidgets = false;
                  }),
                )
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
        return Bounce(child: child);
      case AnimationType.Flash:
        return Flash(
          child: child,
        );
      case AnimationType.HeadShake:
        return HeadShake(
          child: child,
        );
      case AnimationType.HeartBeat:
        return HeartBeat(
          child: child,
        );
      case AnimationType.Jello:
        return Jello(
          child: child,
        );
      case AnimationType.Pulse:
        return Pulse(
          child: child,
        );
      case AnimationType.RubberBand:
        return RubberBand(
          child: child,
        );
      case AnimationType.Shake:
        return Shake(
          child: child,
        );
      case AnimationType.Swing:
        return Swing(
          child: child,
        );
      case AnimationType.Tada:
        return Tada(
          child: child,
        );
      case AnimationType.Wobble:
        return Wobble(
          child: child,
        );
      case AnimationType.BounceIn:
        return BounceIn(
          child: child,
        );
      case AnimationType.BounceInDown:
        return BounceInDown(
          child: child,
        );
      case AnimationType.BounceInLeft:
        return BounceInLeft(
          child: child,
        );
      case AnimationType.BounceInRight:
        return BounceInRight(
          child: child,
        );
      case AnimationType.BounceInUp:
        return BounceInUp(
          child: child,
        );
      case AnimationType.BounceOut:
        return BounceOut(
          child: child,
        );
      case AnimationType.BounceOutDown:
        return BounceOutDown(
          child: child,
        );
      case AnimationType.BounceOutLeft:
        return BounceOutLeft(
          child: child,
        );
      case AnimationType.BounceOutRight:
        return BounceOutRight(
          child: child,
        );
      case AnimationType.BounceOutUp:
        return BounceOutUp(
          child: child,
        );
      case AnimationType.FadeIn:
        return FadeIn(
          child: child,
        );
      case AnimationType.FadeInDown:
        return FadeInDown(
          child: child,
        );
      case AnimationType.FadeInDownBig:
        return FadeInDownBig(
          child: child,
        );
      case AnimationType.FadeInLeft:
        return FadeInLeft(
          child: child,
        );
      case AnimationType.FadeInLeftBig:
        return FadeInLeftBig(
          child: child,
        );
      case AnimationType.FadeInRight:
        return FadeInRight(
          child: child,
        );
      case AnimationType.FadeInRightBig:
        return FadeInRightBig(
          child: child,
        );
      case AnimationType.FadeInUp:
        return FadeInUp(
          child: child,
        );
      case AnimationType.FadeInUpBig:
        return FadeInUpBig(
          child: child,
        );
      case AnimationType.FadeOut:
        return FadeOut(
          child: child,
        );
      case AnimationType.FadeOutDown:
        return FadeOutDown(
          child: child,
        );
      case AnimationType.FadeOutDownBig:
        return FadeOutDownBig(
          child: child,
        );
      case AnimationType.FadeOutLeft:
        return FadeOutLeft(
          child: child,
        );
      case AnimationType.FadeOutLeftBig:
        return FadeOutLeftBig(
          child: child,
        );
      case AnimationType.FadeOutRight:
        return FadeOutRight(
          child: child,
        );
      case AnimationType.FadeOutRightBig:
        return FadeOutRightBig(
          child: child,
        );
      case AnimationType.FadeOutUp:
        return FadeOutUp(
          child: child,
        );
      case AnimationType.FadeOutUpBig:
        return FadeOutUpBig(
          child: child,
        );
      case AnimationType.Flip:
        return Flip(
          child: child,
        );
      case AnimationType.FlipInX:
        return FlipInX(
          child: child,
        );
      case AnimationType.FlipInY:
        return FlipInY(
          child: child,
        );
      case AnimationType.FlipOutX:
        return FlipOutX(
          child: child,
        );
      case AnimationType.FlipOutY:
        return FlipOutY(
          child: child,
        );
      case AnimationType.LightSpeedIn:
        return LightSpeedIn(
          child: child,
        );
      case AnimationType.LightSpeedOut:
        return LightSpeedOut(
          child: child,
        );
      case AnimationType.RotateIn:
        return RotateIn(
          child: child,
        );
      case AnimationType.RotateInDownLeft:
        return RotateInDownLeft(
          child: child,
        );
      case AnimationType.RotateInDownRight:
        return RotateInDownRight(
          child: child,
        );
      case AnimationType.RotateInUpLeft:
        return RotateInUpLeft(
          child: child,
        );
      case AnimationType.RotateInUpRight:
        return RotateInUpRight(
          child: child,
        );
      case AnimationType.RotateOut:
        return RotateOut(
          child: child,
        );
      case AnimationType.RotateOutDownLeft:
        return RotateOutDownLeft(
          child: child,
        );
      case AnimationType.RotateOutDownRight:
        return RotateOutDownRight(
          child: child,
        );
      case AnimationType.RotateOutUpLeft:
        return RotateOutUpLeft(
          child: child,
        );
      case AnimationType.RotateOutUpRight:
        return RotateOutUpRight(
          child: child,
        );
      case AnimationType.SlideInDown:
        return SlideInDown(
          child: child,
        );
      case AnimationType.SlideInLeft:
        return SlideInLeft(
          child: child,
        );
      case AnimationType.SlideInRight:
        return SlideInRight(
          child: child,
        );
      case AnimationType.SlideInUp:
        return SlideInUp(
          child: child,
        );
      case AnimationType.SlideOutDown:
        return SlideOutDown(
          child: child,
        );
      case AnimationType.SlideOutLeft:
        return SlideOutLeft(
          child: child,
        );
      case AnimationType.SlideOutRight:
        return SlideOutRight(
          child: child,
        );
      case AnimationType.SlideOutUp:
        return SlideOutUp(
          child: child,
        );
      case AnimationType.Hinge:
        return Hinge(
          child: child,
        );
      case AnimationType.JackInTheBox:
        return JackInTheBox(
          child: child,
        );
      case AnimationType.RollIn:
        return RollIn(
          child: child,
        );
      case AnimationType.RollOut:
        return RollOut(
          child: child,
        );
      case AnimationType.ZoomIn:
        return ZoomIn(
          child: child,
        );
      case AnimationType.ZoomInDown:
        return ZoomInDown(
          child: child,
        );
      case AnimationType.ZoomInLeft:
        return ZoomInLeft(
          child: child,
        );
      case AnimationType.ZoomInRight:
        return ZoomInRight(
          child: child,
        );
      case AnimationType.ZoomInUp:
        return ZoomInUp(
          child: child,
        );
      case AnimationType.ZoomOut:
        return ZoomOut(
          child: child,
        );
      case AnimationType.ZoomOutDown:
        return ZoomOutDown(
          child: child,
        );
      case AnimationType.ZoomOutLeft:
        return ZoomOutLeft(
          child: child,
        );
      case AnimationType.ZoomOutRight:
        return ZoomOutRight(
          child: child,
        );
      case AnimationType.ZoomOutUp:
        return ZoomOutUp(
          child: child,
        );
    }
    return child;
  }
}
