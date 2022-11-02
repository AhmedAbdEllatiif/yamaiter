import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';

class TextWithIconWidget extends StatelessWidget {
  final Color? iconColor;
  final TextStyle? textStyle;
  final String text;
  final IconData iconData;

  const TextWithIconWidget({
    Key? key,
    required this.text,
    required this.iconData,
    this.iconColor,
    this.textStyle,
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
          size: Sizes.dimen_12.w,
        ),
        
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: textStyle ??
                  Theme.of(context).textTheme.caption!.copyWith(
                        color: AppColor.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
            ),
          ),
        ),
      ],
    );
  }
}
