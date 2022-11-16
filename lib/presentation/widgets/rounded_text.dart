import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../common/constants/app_utils.dart';
import '../../common/constants/sizes.dart';

class RoundedText extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  /// right icon
  final IconData? rightIconData;
  final Color rightIconColor;
  final double? rightIconSize;

  /// left icon
  final IconData? leftIconData;
  final Color leftIconColor;
  final double? leftIconSize;


  final Color background;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? textSize;
  final FontWeight? fontWeight;

  const RoundedText({
    Key? key,
    required this.text,
    this.onPressed,
    this.textStyle,
    this.textSize,
    this.fontWeight,
    this.textColor,
    this.background = AppColor.primaryDarkColor,
    this.rightIconData,
    this.rightIconSize,
    this.rightIconColor = AppColor.accentColor,
    this.leftIconData,
    this.leftIconColor = AppColor.accentColor,
    this.leftIconSize,
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
              if (rightIconData != null)
                Icon(
                  rightIconData,
                  color: rightIconColor,
                  size: rightIconSize ?? Sizes.dimen_16.w,
                ),

              if (rightIconData != null)
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
                      Theme
                          .of(context)
                          .textTheme
                          .caption!
                          .copyWith(
                        height: 1.1,
                        fontSize: textSize,
                        fontWeight: fontWeight ?? FontWeight.bold,
                        color: textColor ??
                            (background == AppColor.primaryDarkColor
                                ? AppColor.accentColor
                                : AppColor.primaryDarkColor),
                      ),
                ),
              ),

              if (leftIconData != null)
              const SizedBox(
                width: 5,
              ),

              /// icon
              if (leftIconData != null)
                Icon(
                  leftIconData,
                  color: leftIconColor,
                  size: leftIconSize ?? Sizes.dimen_16.w,
                ),



            ],
          ),
        ),
      ),
    );
  }
}
