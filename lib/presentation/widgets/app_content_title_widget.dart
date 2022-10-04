import 'package:flutter/material.dart';

import '../themes/theme_color.dart';

class AppContentTitleWidget extends StatelessWidget {
  final String title;
  final Color textColor;
  const AppContentTitleWidget({Key? key, required this.title,  this.textColor = AppColor.primaryDarkColor,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  //==> title
      Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold),
      );
  }
}
