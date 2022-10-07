import 'package:flutter/material.dart';

import '../themes/theme_color.dart';

class CustomCircularProgressBar extends StatelessWidget {
  final double? scale;
  final double? progress;

  const CustomCircularProgressBar({
    Key? key,
    this.scale,
    this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: CircularProgressIndicator(
        value: progress,
        color: AppColor.accentColor,
        strokeWidth: 2.5,
      ),
    );
  }
}
