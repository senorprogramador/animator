import './animator_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

class LightSpeed extends AnimatorGroup {
  LightSpeed({Key? key, AnimationPlayStates? playState})
      : super(key: key, playState: playState);

  @override
  LightSpeedState createState() => LightSpeedState();
}

class LightSpeedState extends AnimatorGroupState<LightSpeed> {
  @override
  int get numKeys => 2;

  List<String> labels = [
    "LightSpeedIn",
    "LightSpeedOut",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(numKeys, (int index) {
        switch (index) {
          case 0:
            return LightSpeedIn(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 1:
            return LightSpeedOut(
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
