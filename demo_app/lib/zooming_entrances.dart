import './animator_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

class ZoomingEntrances extends AnimatorGroup {
  ZoomingEntrances({Key? key, AnimationPlayStates? playState})
      : super(key: key, playState: playState);

  @override
  ZoomingEntrancesState createState() => ZoomingEntrancesState();
}

class ZoomingEntrancesState extends AnimatorGroupState<ZoomingEntrances> {
  @override
  int get numKeys => 5;

  List<String> labels = [
    "ZoomIn",
    "ZoomInDown",
    "ZoomInLeft",
    "ZoomInRight",
    "ZoomInUp",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(numKeys, (int index) {
        switch (index) {
          case 0:
            return ZoomIn(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 1:
            return ZoomInDown(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 2:
            return ZoomInLeft(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 3:
            return ZoomInRight(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 4:
            return ZoomInUp(
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
