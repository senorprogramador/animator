import './animator_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

class ZoomingExits extends AnimatorGroup {
  ZoomingExits({Key? key, AnimationPlayStates? playState})
      : super(key: key, playState: playState);

  @override
  ZoomingExitsState createState() => ZoomingExitsState();
}

class ZoomingExitsState extends AnimatorGroupState<ZoomingExits> {
  @override
  int get numKeys => 5;

  List<String> labels = [
    "ZoomOut",
    "ZoomOutDown",
    "ZoomOutLeft",
    "ZoomOutRight",
    "ZoomOutUp",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(numKeys, (int index) {
        switch (index) {
          case 0:
            return ZoomOut(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 1:
            return ZoomOutDown(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 2:
            return ZoomOutLeft(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 3:
            return ZoomOutRight(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 4:
            return ZoomOutUp(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
        }
        return null;
      }).where((Widget? w) => w != null).toList() as List<Widget>,
    );
  }
}
