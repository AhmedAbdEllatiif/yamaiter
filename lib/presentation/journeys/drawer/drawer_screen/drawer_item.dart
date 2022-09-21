import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

class DrawerItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function() onPressed;

  const DrawerItem({Key? key, required this.iconData, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.primaryDarkColor,
      child: InkWell(
        onTap: onPressed,
        splashColor: AppColor.accentColor,
        hoverColor: AppColor.accentColor,
        child: Container(
          color: AppColor.primaryDarkColor,
          padding: EdgeInsets.only(
              bottom: Sizes.dimen_8.h, right: Sizes.dimen_4.w,left: Sizes.dimen_4.w),
          child: Row(
            children: [
              Icon(
                iconData,
                color: AppColor.white,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_2.w),
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColor.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
