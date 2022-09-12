import 'package:flutter/material.dart';

import '../enum/animation_type.dart';


extension ToAnimate on Widget {
  /// * [rotateDuration]
  /// Example:animate(
  ///                   slideDuration: const Duration(milliseconds: 300),
  ///                   fadeDuration: const Duration(milliseconds: 300),
  ///                   map: {
  ///                     /// slide animation
  ///                     AnimationType.slide: {
  // /                      //SlideOffset.begin: const Offset(0.0, 5.0),
  ///                       //SlideOffset.end: const Offset(0.0, 0.0),
  ///                     },
  ///
  ///                     /// fade animation
  ///                     AnimationType.fade: {
  ///                       // FadeOpacity.begin: "sad",
  ///                       //FadeOpacity.end: "sadasd",
  ///                     }
  ///                   },
  ///                 ),

  Widget animate<Widget>({
    Map<AnimationType, Map<dynamic, dynamic>> map = const {},
    Duration rotateDuration = const Duration(milliseconds: 500),
    Duration fadeDuration = const Duration(milliseconds: 500),
    Duration slideDuration = const Duration(milliseconds: 500),
    Duration delayRotation = Duration.zero,
    Duration delayFade = Duration.zero,
    Duration delaySlide = Duration.zero,
    Duration delaySize = Duration.zero,
  }) {
    return CustomAnimatedWidget(
      map: map,
      rotateDuration: rotateDuration,
      fadeDuration: fadeDuration,
      slideDuration: slideDuration,
      delayRotation: delayRotation,
      delayFade: delayFade,
      delaySlide: delaySlide,
      delaySize: delaySize,
      childWidget: this,
    ) as Widget;
  }
}

class CustomAnimatedWidget extends StatefulWidget {
  final Map<AnimationType, Map<dynamic, dynamic>> map;
  final Duration rotateDuration;

  final Duration fadeDuration;

  final Duration slideDuration;

  final Duration delayRotation;

  final Duration delayFade;

  final Duration delaySlide;

  final Duration delaySize;

  final Widget childWidget;

  const CustomAnimatedWidget(
      {Key? key,
      required this.childWidget,
      required this.map,
      required this.rotateDuration,
      required this.fadeDuration,
      required this.slideDuration,
      required this.delayRotation,
      required this.delayFade,
      required this.delaySlide,
      required this.delaySize})
      : super(key: key);

  @override
  State<CustomAnimatedWidget> createState() => _CustomAnimatedWidgetState();
}

class _CustomAnimatedWidgetState extends State<CustomAnimatedWidget>
    with TickerProviderStateMixin {
  late Map<AnimationType, Map<dynamic, dynamic>> map;
  late AnimationController _rotationController;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _sizedController;
  late final Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    map = widget.map;

    _rotationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000), value: 0);

    _slideController = AnimationController(
        vsync: this, duration: widget.slideDuration, value: 0);

    _fadeController = AnimationController(
        vsync: this, duration: widget.fadeDuration, value: 0);

    _sizedController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000), value: 0.0);

    /*   Future.delayed(widget.delaySize, () async {
      _sizedController.forward();
    }); */

    Future.delayed(widget.delayRotation, () async {
      _rotationController.forward();
    });

    Future.delayed(widget.delayFade, () async {
      _fadeController.forward();
    });

    Future.delayed(widget.delaySlide, () async {
      _slideController.forward();
    });
  }

  @override
  void dispose(){
    _rotationController.dispose();
    _slideController.dispose();
    _fadeController.dispose();
    _sizedController.dispose();
    super.dispose();
}

  /// return the the opacity vale for FadeTransition
  double getOpacity(FadeOpacity fadeOpacity) {
    /// for opacity begin
    if (fadeOpacity == FadeOpacity.begin) {
      if (map[AnimationType.fade]!.containsKey(FadeOpacity.begin)) {
        //==> Try to parse begin value
        final beginValue = double.tryParse(
            map[AnimationType.fade]![FadeOpacity.begin].toString());

        //==>  print if value cannot parse
        if (beginValue == null) {
          debugPrint(
              "Cannot parse '${map[AnimationType.fade]![FadeOpacity.begin]}' "
              "as begin opacity to double will use default value 0.0");
        }
        return beginValue ?? 0.0;
      }

      debugPrint("FadeOpacity.begin not passed will use default value 0.0");

      return 0.0;
    }

    /// for opacity end
    else {
      if (map[AnimationType.fade]!.containsKey(FadeOpacity.end)) {
        //==> Try to parse end value
        final beginValue = double.tryParse(
            map[AnimationType.fade]![FadeOpacity.end].toString());

        //==>  print if value cannot parse
        if (beginValue == null) {
          debugPrint(
              "Cannot parse '${map[AnimationType.fade]![FadeOpacity.end]}' "
              "as end opacity to double will use default value 1.0");
        }

        return beginValue ?? 1.0;
      }

      debugPrint("FadeOpacity.begin not passed will use default value 1.0");

      return 1.0;
    }
  }

  /// return the offset of SlideTransition
  Offset getOffset(SlideOffset slideOffset) {
    /// for begin slide offset
    if (slideOffset == SlideOffset.begin) {
      if (map[AnimationType.slide]!.containsKey(SlideOffset.begin)) {
        final beginOffset = map[AnimationType.slide]![SlideOffset.begin];

        if (beginOffset != null && beginOffset is Offset) {
          return beginOffset;
        } else {
          debugPrint(
              "Cannot parse passed value'${map[AnimationType.slide]![SlideOffset.begin]}' "
              "as begin slideOffset to Offset() will use defaultOffset(0.0, -0.5)");
          return const Offset(0.0, -0.5);
        }
      }
      debugPrint(
          "SlideOffset.begin not passed will use default Offset(0.0, -0.5)");
      return const Offset(0.0, -0.5);
    }

    /// for end slide offset
    else {
      if (map[AnimationType.slide]!.containsKey(SlideOffset.end)) {
        final endOffset = map[AnimationType.slide]![SlideOffset.end];
        if (endOffset != null && endOffset is Offset) {
          return endOffset;
        } else {
          debugPrint(
              "Cannot parse passed value'${map[AnimationType.slide]![SlideOffset.end]}' "
              "as end slideOffset to Offset() will use defaultOffset(0.0, 0.0)");
          return const Offset(0.0, 0.0);
        }
      }
      debugPrint(
          "SlideOffset.end not passed will use default Offset(0.0, 0.0)");
      return const Offset(0.0, 0.0);
    }
  }

  /// return the rotation cycle for RotationTransition
  Map<dynamic, dynamic> getRotationCycle() {
    Curve curve = Curves.linear;
    Curve? reverseCurve;
    TriggerOn triggerOn = TriggerOn.pageLoad;
    Duration duration = const Duration(milliseconds: 500);
    bool repeat = false;
    Tween<double>? tween;

    if (map[AnimationType.rotate] != null) {
      /// init curve
      final containsCurve =
          map[AnimationType.rotate]!.containsKey(RotationAnimationParams.curve);
      if (containsCurve) {
        final curveFromMap =
            map[AnimationType.size]![RotationAnimationParams.curve];
        if (curveFromMap is Curve) {
          curve = curveFromMap;
        }
      }

      /// init reverseCurve
      final containsReverseCurve = map[AnimationType.rotate]!
          .containsKey(RotationAnimationParams.reverseCurve);
      if (containsReverseCurve) {
        final reverseCurveFromMap =
            map[AnimationType.rotate]![RotationAnimationParams.reverseCurve];
        if (reverseCurveFromMap is Curve) {
          curve = reverseCurveFromMap;
        }
      }

      /// init duration
      final containsDuration = map[AnimationType.rotate]!
          .containsKey(RotationAnimationParams.duration);
      if (containsDuration) {
        final durationFromMap =
            map[AnimationType.rotate]![RotationAnimationParams.duration];
        if (durationFromMap is Duration) {
          duration = durationFromMap;
        }
      }

      /// init triggerOn
      final containsTriggerOn = map[AnimationType.rotate]!
          .containsKey(RotationAnimationParams.triggerOn);
      if (containsTriggerOn) {
        final triggerOnFromMap =
            map[AnimationType.rotate]![RotationAnimationParams.triggerOn];
        if (triggerOnFromMap is TriggerOn) {
          triggerOn = triggerOnFromMap;
        }
      }

      /// init repeat
      final containsRepeat = map[AnimationType.rotate]!
          .containsKey(RotationAnimationParams.repeat);
      if (containsRepeat) {
        final repeatFromMap =
            map[AnimationType.rotate]![RotationAnimationParams.repeat];
        if (repeatFromMap is bool) {
          repeat = repeatFromMap;
        }
      }

      /// init tween
      final containsTween =
          map[AnimationType.rotate]!.containsKey(RotationAnimationParams.tween);
      if (containsTween) {
        final tweenFromMap =
            map[AnimationType.rotate]![RotationAnimationParams.tween];
        if (tweenFromMap is Tween<num>) {
          final begin = tweenFromMap.begin;
          final end = tweenFromMap.end;
          tween = Tween(
            begin: begin != null ? begin.toDouble() : 0.0,
            end: end != null ? end.toDouble() : 1.0,
          );
        }
      }
    }

    //_sizedController.animateTo(200);
    _rotationController.duration = duration;

    //forwardSizeTransition();
    triggerOn == TriggerOn.pageLoad ? forwardRotateTransition() : null;

    repeat ? _rotationController.repeat() : null;

    final parent =
        tween != null ? _rotationController.drive(tween) : _rotationController;
    final _animation = CurvedAnimation(
      parent: parent,
      curve: curve,
      reverseCurve: reverseCurve,
    );
    return {
      "animation": _animation,
      RotationAnimationParams.triggerOn: triggerOn,
    };
  }

  Map<dynamic, dynamic> getSizeAnimationParams() {
    Curve curve = Curves.linear;
    Curve? reverseCurve;
    Axis axis = Axis.horizontal;
    double axisAlignment = 0.0;
    bool repeat = false;
    Duration duration = const Duration(seconds: 2);
    TriggerOn triggerOn = TriggerOn.pageLoad;
    Tween<double>? tween;
    double initialValue = 0.0;

    if (map[AnimationType.size] != null) {
      /// init curve
      final containsCurve =
          map[AnimationType.size]!.containsKey(SizeAnimationParam.curve);
      if (containsCurve) {
        final curveFromMap = map[AnimationType.size]![SizeAnimationParam.curve];
        if (curveFromMap is Curve) {
          curve = curveFromMap;
        }
      }

      /// init reverseCurve
      final containsReverseCurve =
          map[AnimationType.size]!.containsKey(SizeAnimationParam.reverseCurve);
      if (containsReverseCurve) {
        final reverseCurveFromMap =
            map[AnimationType.size]![SizeAnimationParam.reverseCurve];
        if (reverseCurveFromMap is Curve) {
          curve = reverseCurveFromMap;
        }
      }

      /// init axis
      final containsAxis =
          map[AnimationType.size]!.containsKey(SizeAnimationParam.axis);
      if (containsAxis) {
        final axisFromMap = map[AnimationType.size]![SizeAnimationParam.axis];
        if (axisFromMap is Axis) {
          axis = axisFromMap;
        }
      }

      /// init AxisAlignment
      final containsAxisAlignment = map[AnimationType.size]!
          .containsKey(SizeAnimationParam.axisAlignment);
      if (containsAxisAlignment) {
        final axisAlignmentFromMap =
            map[AnimationType.size]![SizeAnimationParam.axisAlignment];
        if (axisAlignmentFromMap is double) {
          axisAlignment = axisAlignmentFromMap;
        }
      }

      /// init repeat
      final containsRepeat =
          map[AnimationType.size]!.containsKey(SizeAnimationParam.repeat);
      if (containsRepeat) {
        final repeatFromMap =
            map[AnimationType.size]![SizeAnimationParam.repeat];
        if (repeatFromMap is bool) {
          repeat = repeatFromMap;
        }
      }

      /// init duration
      final containsDuration =
          map[AnimationType.size]!.containsKey(SizeAnimationParam.duration);
      if (containsDuration) {
        final durationFromMap =
            map[AnimationType.size]![SizeAnimationParam.duration];
        if (durationFromMap is Duration) {
          duration = durationFromMap;
        }
      }

      /// init triggerOn
      final containsTriggerOn =
          map[AnimationType.size]!.containsKey(SizeAnimationParam.triggerOn);
      if (containsTriggerOn) {
        final triggerOnFromMap =
            map[AnimationType.size]![SizeAnimationParam.triggerOn];
        if (triggerOnFromMap is TriggerOn) {
          triggerOn = triggerOnFromMap;
        }
      }

      /// init tween
      final containsTween =
          map[AnimationType.size]!.containsKey(SizeAnimationParam.tween);
      if (containsTween) {
        final tweenFromMap = map[AnimationType.size]![SizeAnimationParam.tween];
        if (tweenFromMap is Tween<num>) {
          final begin = tweenFromMap.begin;
          final end = tweenFromMap.end;
          tween = Tween(
            begin: begin != null ? begin.toDouble() : 0.0,
            end: end != null ? end.toDouble() : 1.0,
          );
        }
      }

      /// init initialValue
      final containsInitialValue =
          map[AnimationType.size]!.containsKey(SizeAnimationParam.initialValue);
      if (containsInitialValue) {
        final initialValueFromMap =
            map[AnimationType.size]![SizeAnimationParam.initialValue];
        if (initialValueFromMap is num) {
          initialValue = initialValueFromMap.toDouble();
        }
      }
    }

    //_sizedController.animateTo(200);
    _sizedController.duration = duration;

    //forwardSizeTransition();
    triggerOn == TriggerOn.pageLoad ? forwardSizeTransition() : null;

    repeat ? _sizedController.repeat() : null;

    _sizedController.value = initialValue;

    final parent =
        tween != null ? _sizedController.drive(tween) : _sizedController;

    final _animation = CurvedAnimation(
        parent: parent, curve: curve, reverseCurve: reverseCurve);

    return {
      "animation": _animation,
      SizeAnimationParam.triggerOn: triggerOn,
      SizeAnimationParam.axis: axis,
      SizeAnimationParam.axisAlignment: axisAlignment,
    };
  }

  void forwardSizeTransition() {
    Duration delay = Duration.zero;
    if (map[AnimationType.size] != null) {
      /// init delay
      final containsDelay =
          map[AnimationType.size]!.containsKey(SizeAnimationParam.delay);
      if (containsDelay) {
        final delayFromMap = map[AnimationType.size]![SizeAnimationParam.delay];
        if (delayFromMap is Duration) {
          delay = delayFromMap;
        }
      }
    }

    Future.delayed(delay, () async {
      _sizedController.forward(from: 0.0);
    });
  }

  void forwardRotateTransition() {
    Duration delay = Duration.zero;
    if (map[AnimationType.rotate] != null) {
      /// init delay
      final containsDelay =
          map[AnimationType.rotate]!.containsKey(RotationAnimationParams.delay);
      if (containsDelay) {
        final delayFromMap =
            map[AnimationType.rotate]![RotationAnimationParams.delay];
        if (delayFromMap is Duration) {
          delay = delayFromMap;
        }
      }
    }

    Future.delayed(delay, () async {
      _rotationController.forward(from: 0.0);
    });
  }

  Widget _buildWidgetWithAnimation() {
    final hasSlide = map.containsKey(AnimationType.slide);
    final hasFade = map.containsKey(AnimationType.fade);
    final hasRotate = map.containsKey(AnimationType.rotate);
    final hasSize = map.containsKey(AnimationType.size);

    /// if has SlideTransition
    if (hasSlide) {
      return slideTransition(
          hasFade: hasFade, hasRotate: hasRotate, hasSize: hasSize);
    }

    /// if has FadeTransition
    if (hasFade) {
      return fadeTransition(hasRotate: hasRotate, hasSize: hasSize);
    }

    /// if has RotationTransition
    if (hasRotate) {
      return rotationTransition(hasSize: hasSize);
    }

    /// has no transition use the default FadeTransition
    /*return FadeTransition(
      opacity: _fadeController.drive(Tween(
        begin: 0,
        end: 1.0,
      )),
      child: widget.childWidget,
    );*/

    return fadeTransition(hasRotate: false, hasSize: false);
  }

  /// Build SlideTransition
  SlideTransition slideTransition(
      {required bool hasFade, required bool hasRotate, required bool hasSize}) {
    return SlideTransition(
      position: _slideController.drive(Tween(
        begin: getOffset(SlideOffset.begin),
        end: getOffset(SlideOffset.end),
      )),
      child: hasFade
          ? fadeTransition(hasRotate: hasRotate, hasSize: hasSize)
          : widget.childWidget,
    );
  }

  /// Build SizeTransition
  FadeTransition fadeTransition(
      {required bool hasRotate, required bool hasSize}) {
    return FadeTransition(
      opacity: _fadeController.drive(Tween(
        begin: getOpacity(FadeOpacity.begin),
        end: getOpacity(FadeOpacity.end),
      )),
      child:
          hasRotate ? rotationTransition(hasSize: hasSize) : widget.childWidget,
    );
  }

  /// build RotationTransition
  RotationTransition rotationTransition({required bool hasSize}) {
    final params = getRotationCycle();
    /*return AnimatedBuilder(
        animation:  params["animation"],
      builder: (buildContext, child) {
          return  hasSize
              ? sizeTransition(childWidget: widget.childWidget)
              : widget.childWidget;
      },

    );*/ /*  double shake(double animation) =>
        2 * (0.5 - (0.5 - CurveTween(curve: Curves.elasticIn).transform(animation)).abs());
   return TweenAnimationBuilder<double>(

      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 2000),
      builder: (context, animation, child) => Transform.translate(
        offset: Offset(20 * shake(animation), 0),
        child: widget.childWidget,
      ),
      child: widget.childWidget,
    );*/

    return RotationTransition(
      turns: params["animation"],
      child: hasSize
          ? sizeTransition(childWidget: widget.childWidget)
          : widget.childWidget,
    );
  }

  /// Build SizeTransition
  SizeTransition sizeTransition({required Widget childWidget}) {
    final sizeParams = getSizeAnimationParams();
    return SizeTransition(
      sizeFactor: sizeParams["animation"],
      axis: sizeParams[SizeAnimationParam.axis],
      axisAlignment: sizeParams[SizeAnimationParam.axisAlignment],
      child: GestureDetector(
        onTap: () {
          if (sizeParams[SizeAnimationParam.triggerOn] == TriggerOn.click) {
            forwardSizeTransition();
          }
        },
        child: childWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgetWithAnimation();
  }
}
