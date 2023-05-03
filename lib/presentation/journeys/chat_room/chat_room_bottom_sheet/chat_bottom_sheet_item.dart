import 'package:flutter/material.dart';

import '../../../themes/theme_color.dart';

class ChatBottomSheetItem extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function() onPressed;

  const ChatBottomSheetItem(
      {Key? key, required this.text, required this.iconData, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [

          /// icon
          Icon(
            iconData,
            color: AppColor.white,
          ),

          /// text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              text,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                color: AppColor.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
