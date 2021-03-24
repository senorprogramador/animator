import './animator_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

class RotatingExits extends AnimatorGroup {
  RotatingExits({Key? key, AnimationPlayStates? playState})
      : super(key: key, playState: playState);

  @override
  RotatingExitsState createState() => RotatingExitsState();
}

class RotatingExitsState extends AnimatorGroupState<RotatingExits> {
  @override
  int get numKeys => 5;

  List<String> labels = [
    "RotateOut",
    "RotateOutDownLeft",
    "RotateOutDownRight",
    "RotateOutUpLeft",
    "RotateOutUpRight",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(numKeys, (int index) {
        switch (index) {
          case 0:
            return RotateOut(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 1:
            return RotateOutDownLeft(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 2:
            return RotateOutDownRight(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 3:
            return RotateOutUpLeft(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 4:
            return RotateOutUpRight(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
        }
       return SizedBox();
      }),
    );
  }
}
