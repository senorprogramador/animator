import 'package:flutter/widgets.dart';

import './animation_preferences.dart';
import 'tween_list.dart';
import 'animator.dart';

abstract class AnimationDefinition {
  AnimationPreferences preferences;
  final bool needsWidgetSize;
  final bool needsScreenSize;
  final double preRenderOpacity;

  AnimationDefinition({
    this.preferences = const AnimationPreferences(),
    this.needsWidgetSize = false,
    this.needsScreenSize = false,
    this.preRenderOpacity = 1.0,
  }) {
    assert(this.preferences != null, '$this preferences cannot be null');
    assert(
        this.needsWidgetSize != null, '$this needsWidgetSize cannot be null');
    assert(
        this.needsScreenSize != null, '$this needsScreenSize cannot be null');
    assert(
        this.preRenderOpacity != null, '$this preRenderOpacity cannot be null');
  }

  Map<String, TweenList> getDefinition({Size screenSize, Size widgetSize});
  Widget build(BuildContext context, Animator animator, Widget child);
}
