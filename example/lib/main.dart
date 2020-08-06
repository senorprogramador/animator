import 'package:flutter/material.dart';

import 'package:flutter_animator/flutter_animator.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<CrossFadeABState> crossFadeAnimation =
      GlobalKey<CrossFadeABState>();

  final GlobalKey<AnimatorWidgetState> basicAnimation =
      GlobalKey<AnimatorWidgetState>();

  final GlobalKey<InOutAnimationState> inOutAnimation =
      GlobalKey<InOutAnimationState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Animator'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20)),
            CrossFadeAB(
              key: crossFadeAnimation,
              childA: Text('A', style: TextStyle(fontSize: 20)),
              childB: Text('B', style: TextStyle(fontSize: 20)),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            FlatButton(
              onPressed: () {
                crossFadeAnimation.currentState.cross();
              },
              child: Text(
                'Cross Animate',
                style: TextStyle(fontSize: 20),
              ),
            ),
            BounceIn(
              key: basicAnimation,
              child: Text(
                'BounceIn',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            FlatButton(
              onPressed: () {
                basicAnimation.currentState.forward();
              },
              child: Text(
                'Animate Bounce',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 40)),
            InOutAnimation(
              key: inOutAnimation,
              child: Text(
                'In & Out',
                style: TextStyle(fontSize: 20),
              ),
              inDefinition: FadeInAnimation(),
              outDefinition: BounceOutDownAnimation(),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            FlatButton(
              onPressed: () {
                if (inOutAnimation.currentState.status !=
                    InOutAnimationStatus.Out) {
                  inOutAnimation.currentState.animateOut();
                } else {
                  inOutAnimation.currentState.animateIn();
                }
              },
              child: Text(
                'Animate In & Out',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
