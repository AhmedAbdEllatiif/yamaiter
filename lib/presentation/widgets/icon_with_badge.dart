import 'package:flutter/material.dart';

import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';

class IconWithBadge extends StatelessWidget {
  final Function() onPressed;
  final IconData iconData;
  final Color iconColor;

  const IconWithBadge(
      {Key? key, required this.onPressed, required this.iconData, this.iconColor= AppColor.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        /// Notification icon
        IconButton(
          icon:  Icon(
            iconData,
            color: iconColor,
          ),
          onPressed: onPressed,
        ),

        /// Badge
        Positioned(
          right: Sizes.dimen_4,
          top: Sizes.dimen_4,
          child: Container(
            padding: const EdgeInsets.all(Sizes.dimen_2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.accentColor,
            ),
            constraints: const BoxConstraints(
              minWidth: Sizes.dimen_16,
              minHeight: Sizes.dimen_16,
            ),
            child: const Text(
              "4",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Sizes.dimen_10,
                color: AppColor.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
