import 'package:flutter/material.dart';
import '../common/extensions/widget_extension.dart';

import '../common/enum/animation_type.dart';

class TransitionPageRouteBuilder<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;
  final RouteSettings customSettings;

  TransitionPageRouteBuilder({
    required this.builder,
    required this.customSettings,
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) =>
        builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child.animate(
          fadeDuration: const Duration(milliseconds: 500),
          map: {
            AnimationType.fade: {
              FadeOpacity.begin: 0.0,
              FadeOpacity.end: 1.0,
            },
          });
    },
    //transitionDuration: const Duration(milliseconds: 300),
    settings: customSettings,
  );
}
