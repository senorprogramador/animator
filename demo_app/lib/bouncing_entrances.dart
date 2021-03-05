import './animator_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

class BouncingEntrances extends AnimatorGroup {
  BouncingEntrances({Key? key, AnimationPlayStates? playState})
      : super(key: key, playState: playState);

  @override
  BouncingEntrancesState createState() => BouncingEntrancesState();
}

class BouncingEntrancesState extends AnimatorGroupState<BouncingEntrances> {
  @override
  int get numKeys => 5;

  List<String> labels = [
    "BounceIn",
    "BounceInDown",
    "BounceInLeft",
    "BounceInRight",
    "BounceInUp",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(numKeys, (int index) {
        switch (index) {
          case 0:
            return BounceIn(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 1:
            return BounceInDown(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 2:
            return BounceInLeft(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 3:
            return BounceInRight(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 4:
            return BounceInUp(
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
