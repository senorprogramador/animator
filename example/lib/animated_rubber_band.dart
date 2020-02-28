import 'package:flutter/widgets.dart';
import 'package:animator/animator.dart';

class AnimatedRubberBand extends StatefulWidget {
  @override
  _AnimatedRubberBandState createState() => _AnimatedRubberBandState();
}

class _AnimatedRubberBandState extends State<AnimatedRubberBand> {
  @override
  Widget build(BuildContext context) {
    return RubberBand(
      child: Text(
        'Animate.css',
        style: TextStyle(fontSize: 60),
      ),
      animationStatusListener: (AnimationStatus status) {
        if(status == AnimationStatus.completed) {
          Future.delayed(Duration.zero, () => setState(() {}));
        }
      },
    );
  }
}
