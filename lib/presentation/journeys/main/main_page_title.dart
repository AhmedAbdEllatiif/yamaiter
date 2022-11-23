import 'package:flutter/material.dart';

import '../../widgets/app_content_title_widget.dart';

class MainPageTitle extends StatelessWidget {
  final String title;
  final IconData? iconData;
  final Function()? onPressed;

  const MainPageTitle({
    Key? key,
    required this.title,
    this.iconData,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppContentTitleWidget(
          title: title,
        ),
        if (iconData != null)
          IconButton(
            icon: Icon(
              iconData,
            ),
            splashRadius: 24,
            onPressed: onPressed ?? () {},
          )
      ],
    );
  }
}
