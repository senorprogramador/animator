import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

import './animation_preferences.dart';
import 'tween_list.dart';
import 'animator.dart';

///[AnimationDefinition] allows you to define a CSS-like animation and apply
///it in a build phase.
///Override this class to define new animations.
abstract class AnimationDefinition {
  ///Pass [AnimationPreferences] to setup offset, duration, autoPlay and
  ///add an [AnimationStatusListener]
  final AnimationPreferences preferences;

  ///When true, instructs [AnimatorWidget] to preRender the child without
  ///animation and extracts the child's size in order to supply it to
  ///[AnimationDefinition].build() in the next render.
  final bool needsWidgetSize;

  ///When true, instructs [AnimatorWidget] to preRender the child without
  ///animation and extracts the screen-size in order to supply it to
  ///[AnimationDefinition].build() in the next render.
  final bool needsScreenSize;

  ///Sets the visibility of the child during the preRender when
  ///[needsWidgetSize] or [needsScreenSize] is set to true.
  ///Use this property to prevent 'flickering' when rendering in-animations.
  final double preRenderOpacity;

  ///Constructor with all parameters' defaults.
  const AnimationDefinition({
    this.preferences = const AnimationPreferences(),
    this.needsWidgetSize = false,
    this.needsScreenSize = false,
    this.preRenderOpacity = 1.0,
  });

  ///[AnimatorWidget] calls getDefinition to gather the animation. Animations
  ///are defined using named [TweenList]s using a Map<String, TweenList>.
  ///Example:
  ///@override
  ///Map<String, TweenList> getDefinition({Size screenSize, Size widgetSize}) {
  /// return {
  ///   "opacity": TweenList<double>([
  ///     TweenPercentage(percent: 0, value: 0.0, curve: Curves.ease),
  ///     TweenPercentage(percent: 100, value: 1.0, curve: Curves.ease),
  ///   ]),
  /// };
  ///}
  Map<String, TweenList> getDefinition({Size screenSize, Size widgetSize});

  ///[AnimatorWidget] calls build to retrieve the animated Widget.
  ///The extracted [Animator] from the getDefinition phase is injected to
  ///supply a controller and the [Animation] objects.
  ///Example:
  ///@override
  ///Widget build(BuildContext context, Animator animator, Widget child) {
  /// return FadeTransition(
  ///   opacity: animation.get('opacity'),
  ///   child: child,
  /// );
  ///}
  Widget build(BuildContext context, Animator animator, Widget child);
}
