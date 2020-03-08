import './animator_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

class RotatingEntrances extends AnimatorGroup {
  RotatingEntrances({Key key, AnimationPlayStates playState})
      : super(key: key, playState: playState);

  @override
  RotatingEntrancesState createState() => RotatingEntrancesState();
}

class RotatingEntrancesState extends AnimatorGroupState<RotatingEntrances> {
  @override
  int get numKeys => 5;

  List<String> labels = [
    "RotateIn",
    "RotateInDownLeft",
    "RotateInDownRight",
    "RotateInUpLeft",
    "RotateInUpRight",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(numKeys, (int index) {
        switch (index) {
          case 0:
            return RotateIn(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 1:
            return RotateInDownLeft(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 2:
            return RotateInDownRight(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 3:
            return RotateInUpLeft(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 4:
            return RotateInUpRight(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
        }
        return null;
      }).where((Widget w) => w != null).toList(),
    );
  }
}
