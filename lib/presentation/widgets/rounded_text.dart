import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../common/constants/app_utils.dart';
import '../../common/constants/sizes.dart';

class RoundedText extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final IconData? iconData;
  final Color background;
  final Color? textColor;
  final Color iconColor;
  final TextStyle? textStyle;
  final double? iconSize;
  final double? textSize;
  final FontWeight? fontWeight;

  const RoundedText({
    Key? key,
    required this.text,
    this.iconData,
    this.onPressed,
    this.textStyle,
    this.iconSize,
    this.textSize,
    this.fontWeight,
    this.textColor,
    this.background = AppColor.primaryDarkColor,
    this.iconColor = AppColor.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(
          left: Sizes.dimen_4.w,
          top: Sizes.dimen_10,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.dimen_5,
          horizontal: Sizes.dimen_15,
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(
            AppUtils.cornerRadius.w,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// icon
              if (iconData != null)
                Icon(
                  iconData,
                  color: iconColor,
                  size: iconSize ?? Sizes.dimen_16.w,
                ),

              if (iconData != null)
                const SizedBox(
                  width: 5,
                ),

              /// text
              Flexible(
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: textStyle ??
                      Theme.of(context).textTheme.caption!.copyWith(
                            height: 1.3,
                            fontSize: textSize,
                            fontWeight: fontWeight ?? FontWeight.bold,
                            color: textColor ??
                                (background == AppColor.primaryDarkColor
                                    ? AppColor.accentColor
                                    : AppColor.primaryDarkColor),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
