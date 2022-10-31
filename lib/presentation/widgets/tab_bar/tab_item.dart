import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../../common/constants/sizes.dart';

class TabItem extends StatelessWidget {
  //final IconData iconData;
  final String text;
  final double? height;
  final TextStyle? textStyle;

  const TabItem({
    Key? key,
    //required this.iconData,
    required this.text,
    this.textStyle,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      /// height
      height: height,

      /// icon
      /*icon: Icon(iconData,
          size: ResponsiveValue(context,
              defaultValue: Sizes.dimen_24,
              valueWhen: [
                const Condition.largerThan(name: TABLET, value: Sizes.dimen_26),
                const Condition.equals(name: TABLET, value: Sizes.dimen_24),
                const Condition.equals(name: MOBILE, value: Sizes.dimen_24),
                const Condition.smallerThan(
                    name: MOBILE, value: Sizes.dimen_20),
              ]).value),*/

      /// child as text
      child: Text(
        text,
        style: textStyle ?? TextStyle(
            fontSize: ResponsiveValue(context,
                defaultValue: Sizes.dimen_16.sp,
                valueWhen: [
              Condition.largerThan(name: TABLET, value: Sizes.dimen_16.sp),
              Condition.equals(name: TABLET, value: Sizes.dimen_15.sp),
              Condition.equals(name: MOBILE, value: Sizes.dimen_15.sp),
              Condition.smallerThan(name: MOBILE, value: Sizes.dimen_15.sp),
            ]).value),
      ),
    );
  }
}
