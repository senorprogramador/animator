import 'package:flutter/animation.dart';
import 'package:flutter_animator/flutter_animator.dart';

///Use this class to setup preferences inside your [AnimationDefinition]s
///[AnimatorWidget] uses preferences to automatically apply offset, duration,
///autoPlay and add an [AnimationStatusListener].
class AnimationPreferences {
  ///Defines the magnitude of the animation (1.0 = 100%, 0.5 = 50%, etc.)
  final double magnitude;

  ///Defines an offset for the [AnimationDefinition].
  final Duration offset;

  ///Defines a duration for the [AnimationDefinition]
  final Duration duration;

  ///Defines autoPlay for the [AnimationDefinition], [AnimatorWidget] uses this
  ///to initially start an animation upon render.
  final AnimationPlayStates? autoPlay;

  ///Adds an [AnimationStatusListener] to the generated [AnimationController]
  ///inside an [AnimatorInstance]
  final AnimationStatusListener? animationStatusListener;

  ///Constructor with defaults.
  const AnimationPreferences({
    this.magnitude = 1,
    this.offset = Duration.zero,
    this.duration = const Duration(seconds: 1),
    this.autoPlay = AnimationPlayStates.Forward,
    this.animationStatusListener,
  });

  ///Shorthand to initialize a copy with one or more changed parameters.
  AnimationPreferences copyWith({
    Duration? offset,
    Duration? duration,
    AnimationPlayStates? autoPlay,
    AnimationStatusListener? animationStatusListener,
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
