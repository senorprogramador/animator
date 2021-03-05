import './animator_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

class Flippers extends AnimatorGroup {
  Flippers({Key? key, AnimationPlayStates? playState})
      : super(key: key, playState: playState);

  @override
  FlippersState createState() => FlippersState();
}

class FlippersState extends AnimatorGroupState<Flippers> {
  @override
  int get numKeys => 5;

  List<String> labels = [
    "Flip",
    "FlipInX",
    "FlipInY",
    "FlipOutX",
    "FlipOutY",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(numKeys, (int index) {
        switch (index) {
          case 0:
            return Flip(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 1:
            return FlipInX(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 2:
            return FlipInY(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 3:
            return FlipOutX(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 4:
            return FlipOutY(
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
