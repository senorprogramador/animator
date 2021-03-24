import './animator_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

class SlidingEntrances extends AnimatorGroup {
  SlidingEntrances({Key? key, AnimationPlayStates? playState})
      : super(key: key, playState: playState);

  @override
  SlidingEntrancesState createState() => SlidingEntrancesState();
}

class SlidingEntrancesState extends AnimatorGroupState<SlidingEntrances> {
  @override
  int get numKeys => 4;

  List<String> labels = [
    "SlideInDown",
    "SlideInLeft",
    "SlideInRight",
    "SlideInUp",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(numKeys, (int index) {
        switch (index) {
          case 0:
            return SlideInDown(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 1:
            return SlideInLeft(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 2:
            return SlideInRight(
              key: keys[index],
              child: AnimatorCard(labels[index], colors[index]),
              preferences: AnimationPreferences(autoPlay: playState),
            );
          case 3:
            return SlideInUp(
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
