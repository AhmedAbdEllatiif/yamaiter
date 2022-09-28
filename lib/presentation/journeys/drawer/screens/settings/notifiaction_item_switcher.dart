import 'package:flutter/material.dart';

import '../../../../themes/theme_color.dart';

class NotificationItemSwitcher extends StatefulWidget {
  final String title;

  const NotificationItemSwitcher({Key? key, required this.title})
      : super(key: key);

  @override
  State<NotificationItemSwitcher> createState() =>
      _NotificationItemSwitcherState();
}

class _NotificationItemSwitcherState extends State<NotificationItemSwitcher> {
  bool currentValue = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: Theme
              .of(context)
              .textTheme
              .titleSmall!
              .copyWith(
              color: AppColor.primaryDarkColor),
        ),
        Switch(
          value: currentValue,
          inactiveThumbColor: AppColor.primaryDarkColor,
          inactiveTrackColor: AppColor.gray.withOpacity(0.6),
          activeTrackColor: AppColor.gray.withOpacity(0.6),
          activeColor: AppColor.green,
          onChanged: (value) {
            setState(() {
              currentValue = value;
            });
          },
        ),
      ],
    );
  }
}
