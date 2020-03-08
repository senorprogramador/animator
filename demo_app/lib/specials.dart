import './animator_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

class Specials extends AnimatorGroup {
  Specials({Key key, AnimationPlayStates playState})
      : super(key: key, playState: playState);

  @override
  SpecialsState createState() => SpecialsState();
}

class SpecialsState extends AnimatorGroupState<Specials> {
  @override
  int get numKeys => 4;

  List<String> labels = [
    "Hinge",
    "JackInTheBox",
    "RollIn",
    "RollOut",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(numKeys, (int index) {
        switch (index) {
          case 0:
            return Hinge(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 1:
            return JackInTheBox(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 2:
            return RollIn(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 3:
            return RollOut(
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
