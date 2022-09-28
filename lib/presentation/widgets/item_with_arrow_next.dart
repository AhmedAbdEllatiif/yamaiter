import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';

class ItemWithArrowNext extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final EdgeInsets? padding;

  const ItemWithArrowNext(
      {Key? key, required this.title, required this.onPressed, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: AppColor.primaryColor,
      borderRadius: BorderRadius.circular(AppUtils.cornerRadius),
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(vertical: Sizes.dimen_4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColor.primaryDarkColor),
              ),
            ),
             Icon(
              Icons.arrow_forward_ios_outlined,
              color: AppColor.gray,
              size: Sizes.dimen_8.h,
            ),
          ],
        ),
      ),
    );
  }
}
