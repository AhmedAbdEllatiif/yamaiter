import 'package:flutter/material.dart';

import '../themes/theme_color.dart';

class LastListItem extends StatelessWidget {
  final Color dotsColor;

  const LastListItem({Key? key,  this.dotsColor = AppColor.primaryDarkColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "...",
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: dotsColor, fontWeight: FontWeight.bold),
    );
  }
}
