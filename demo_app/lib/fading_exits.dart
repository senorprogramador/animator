import './animator_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

class FadingExits extends AnimatorGroup {
  FadingExits({Key key, AnimationPlayStates playState})
      : super(key: key, playState: playState);

  @override
  FadingExitsState createState() => FadingExitsState();
}

class FadingExitsState extends AnimatorGroupState<FadingExits> {
  @override
  int get numKeys => 9;

  List<String> labels = [
    "FadeOut",
    "FadeOutDown",
    "FadeOutDownBig",
    "FadeOutLeft",
    "FadeOutLeftBig",
    "FadeOutRight",
    "FadeOutRightBig",
    "FadeOutUp",
    "FadeOutUpBig",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(numKeys, (int index) {
        switch (index) {
          case 0:
            return FadeOut(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 1:
            return FadeOutDown(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 2:
            return FadeOutDownBig(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 3:
            return FadeOutLeft(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 4:
            return FadeOutLeftBig(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 5:
            return FadeOutRight(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 6:
            return FadeOutRightBig(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 7:
            return FadeOutUp(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 8:
            return FadeOutUpBig(
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
