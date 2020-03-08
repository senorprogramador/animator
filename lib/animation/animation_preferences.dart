import 'package:flutter/animation.dart';

import '../animation/animator_play_states.dart';

class AnimationPreferences {
  final Duration offset;
  final Duration duration;
  final AnimationPlayStates autoPlay;
  final AnimationStatusListener animationStatusListener;

  const AnimationPreferences({
    this.offset = Duration.zero,
    this.duration = const Duration(seconds: 1),
    this.autoPlay = AnimationPlayStates.Forward,
    this.animationStatusListener,
  });

  AnimationPreferences copyWith({
    Duration offset,
    Duration duration,
    AnimationPlayStates autoPlay,
    AnimationStatusListener animationStatusListener,
  }) {
    return AnimationPreferences(
      offset: offset ?? this.offset,
      duration: duration ?? this.duration,
      autoPlay: autoPlay ?? this.autoPlay,
      animationStatusListener:
          animationStatusListener ?? this.animationStatusListener,
    );
  }
}
