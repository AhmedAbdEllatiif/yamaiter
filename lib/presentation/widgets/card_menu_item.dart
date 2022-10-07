import 'package:flutter/material.dart';

import '../themes/theme_color.dart';

class CardMenuItem extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const CardMenuItem({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: AppColor.primaryDarkColor),
      ),
    );
  }
}
