import 'package:flutter/material.dart';

import '../themes/theme_color.dart';

class AppContentTitleWidget extends StatelessWidget {
  final String title;
  final Color textColor;
  final TextStyle? textStyle;
  const AppContentTitleWidget({Key? key, required this.title,  this.textColor = AppColor.primaryDarkColor, this.textStyle,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  //==> title
      Text(
        title,
        style: textStyle ?? Theme.of(context).textTheme.titleMedium!.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold),
      );
  }
}
