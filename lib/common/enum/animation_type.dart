import 'package:flutter/material.dart';

enum AnimationType { rotate, slide, fade, size }

enum SlideOffset { begin, end }

enum FadeOpacity { begin, end }

enum RotationAnimationParams {
  duration,
  curve,
  reverseCurve,


  /// * must be a duration
  /// * a [Duration] to delay before starting showing the animation
  delay,


  /// * must be a boolean value
  /// * true==> will repeat the animation infinite times
  /// * true==> will repeat the animation infinite times
  repeat,


  /// * [Tween] double
  tween,

  /// * must be a num with min. value 0 and max. value 1
  /// * 0==> init widget with the beginning of the animation
  /// * 1==> init widget with the end of the animation
  /// /// * default value 0
  initialValue,

  /// 'when to show animation'
  /// *  triggerOn must be instance of [TriggerOn] enum
  /// * [TriggerOn.pageLoad] show animation whenever page is loaded
  /// * [TriggerOn.click] show animation whenever widget is clicked
  /// * default value [TriggerOn.pageLoad]
  triggerOn,
}

enum SizeAnimationParam {
  duration,
  axis,
  axisAlignment,
  curve,
  reverseCurve,

  /// * must be a duration
  /// * a [Duration] to delay before start showing the animation
  delay,

  /// * must be a boolean value
  /// * true==> will repeat the animation infinite times
  /// * false==> will show animation only one time
  repeat,

  /// * [Tween] double
  tween,

  /// * must be a num with min. value 0 and max. value 1
  /// * 0==> init widget with the beginning of the animation
  /// * 1==> init widget with the end of the animation
  /// /// * default value 0
  initialValue,

  /// 'when to show animation'
  /// *  triggerOn must be instance of [TriggerOn] enum
  /// * [TriggerOn.pageLoad] show animation whenever page is loaded
  /// * [TriggerOn.click] show animation whenever widget is clicked
  /// * default value [TriggerOn.pageLoad]
  triggerOn,
}

enum TriggerOn {
  pageLoad,
  click,
}

