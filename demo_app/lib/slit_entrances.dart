import './animator_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

class SlitEntrances extends AnimatorGroup {
  SlitEntrances({Key? key, AnimationPlayStates? playState})
      : super(key: key, playState: playState);

  @override
  SlitEntrancesState createState() => SlitEntrancesState();
}

class SlitEntrancesState extends AnimatorGroupState<SlitEntrances> {
  @override
  int get numKeys => 3;

  List<String> labels = [
    "SlitInDiagonal",
    "SlitInVertical",
    "SlitInHorizontal",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(numKeys, (int index) {
        switch (index) {
          case 0:
            return SlitInDiagonal(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(
                autoPlay: playState,
                duration: Duration(milliseconds: 750),
              ),
            );
          case 1:
            return SlitInVertical(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(
                autoPlay: playState,
                duration: Duration(milliseconds: 750),
              ),
            );
          case 2:
            return SlitInHorizontal(
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
