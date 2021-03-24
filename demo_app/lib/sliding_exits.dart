import './animator_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

class SlidingExits extends AnimatorGroup {
  SlidingExits({Key? key, AnimationPlayStates? playState})
      : super(key: key, playState: playState);

  @override
  SlidingExitsState createState() => SlidingExitsState();
}

class SlidingExitsState extends AnimatorGroupState<SlidingExits> {
  @override
  int get numKeys => 4;

  List<String> labels = [
    "SlideOutDown",
    "SlideOutLeft",
    "SlideOutRight",
    "SlideOutUp",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(numKeys, (int index) {
        switch (index) {
          case 0:
            return SlideOutDown(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 1:
            return SlideOutLeft(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 2:
            return SlideOutRight(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 3:
            return SlideOutUp(
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
