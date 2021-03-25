import './animator_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

class BouncingExits extends AnimatorGroup {
  BouncingExits({Key? key, AnimationPlayStates? playState})
      : super(key: key, playState: playState);

  @override
  BouncingExitsState createState() => BouncingExitsState();
}

class BouncingExitsState extends AnimatorGroupState<BouncingExits> {
  @override
  int get numKeys => 5;

  List<String> labels = [
    "BounceOut",
    "BounceOutDown",
    "BounceOutLeft",
    "BounceOutRight",
    "BounceOutUp",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(numKeys, (int index) {
        switch (index) {
          case 0:
            return BounceOut(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 1:
            return BounceOutDown(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 2:
            return BounceOutLeft(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 3:
            return BounceOutRight(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 4:
            return BounceOutUp(
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
