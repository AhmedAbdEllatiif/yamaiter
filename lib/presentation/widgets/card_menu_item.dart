import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/app_utils.dart';

import '../themes/theme_color.dart';

class CardMenuItem extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const CardMenuItem({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        splashColor: AppColor.accentColor,
        borderRadius: BorderRadius.circular(AppUtils.cornerRadius),
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 2),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColor.primaryDarkColor,
                ),
          ),
        ),
      ),
    );
  }
}
