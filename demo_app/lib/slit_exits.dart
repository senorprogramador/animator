import './animator_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

class SlitExits extends AnimatorGroup {
  SlitExits({Key? key, AnimationPlayStates? playState})
      : super(key: key, playState: playState);

  @override
  SlitExitsState createState() => SlitExitsState();
}

class SlitExitsState extends AnimatorGroupState<SlitExits> {
  @override
  int get numKeys => 3;

  List<String> labels = [
    "SlitOutDiagonal",
    "SlitOutVertical",
    "SlitOutHorizontal",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(numKeys, (int index) {
        switch (index) {
          case 0:
            return SlitOutDiagonal(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(
                autoPlay: playState,
                duration: Duration(milliseconds: 750),
              ),
            );
          case 1:
            return SlitOutVertical(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(
                autoPlay: playState,
                duration: Duration(milliseconds: 750),
              ),
            );
          case 2:
            return SlitOutHorizontal(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(
                autoPlay: playState,
                duration: Duration(milliseconds: 750),
              ),
            );
        }
       return SizedBox();
      }),
    );
  }
}
