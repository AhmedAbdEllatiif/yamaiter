import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';

class TextWithIconWidget extends StatelessWidget {
  final Color? iconColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final String text;
  final IconData iconData;
  final double? iconSize;

  const TextWithIconWidget({
    Key? key,
    required this.text,
    required this.iconData,
    this.iconColor,
    this.textStyle,
    this.iconSize,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
          color: iconColor ?? AppColor.accentColor,
          size: iconSize ?? Sizes.dimen_12.w,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: textStyle ??
                  Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: textColor ?? AppColor.accentColor,
                      fontWeight: FontWeight.bold,
                      height: 1.3),
            ),
          ),
        ),
      ],
    );
  }
}
