import './animator_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

class FadingEntrances extends AnimatorGroup {
  FadingEntrances({Key? key, AnimationPlayStates? playState})
      : super(key: key, playState: playState);

  @override
  FadingEntrancesState createState() => FadingEntrancesState();
}

class FadingEntrancesState extends AnimatorGroupState<FadingEntrances> {
  @override
  int get numKeys => 9;

  List<String> labels = [
    "FadeIn",
    "FadeInDown",
    "FadeInDownBig",
    "FadeInLeft",
    "FadeInLeftBig",
    "FadeInRight",
    "FadeInRightBig",
    "FadeInUp",
    "FadeInUpBig",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(numKeys, (int index) {
        switch (index) {
          case 0:
            return FadeIn(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 1:
            return FadeInDown(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 2:
            return FadeInDownBig(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 3:
            return FadeInLeft(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 4:
            return FadeInLeftBig(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 5:
            return FadeInRight(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 6:
            return FadeInRightBig(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 7:
            return FadeInUp(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 8:
            return FadeInUpBig(
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
