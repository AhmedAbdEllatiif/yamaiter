import 'package:flutter/material.dart';

import '../themes/theme_color.dart';

class AppContentTitleWidget extends StatelessWidget {
  final String title;
  const AppContentTitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  //==> title
      Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColor.primaryDarkColor,
            fontWeight: FontWeight.bold),
      );
  }
}
