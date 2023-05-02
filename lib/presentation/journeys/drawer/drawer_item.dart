import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../common/constants/assets_constants.dart';

class DrawerItem extends StatelessWidget {
  final IconData? iconData;
  final String? svgImage;
  final Color? imgColor;
  final double? imgSize;
  final String title;
  final Function() onPressed;

  const DrawerItem(
      {Key? key,
      this.iconData,
      this.imgColor,
      this.imgSize,
      required this.title,
      required this.onPressed,
      this.svgImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        splashColor: AppColor.accentColor,
        hoverColor: AppColor.accentColor,
        child: Container(
          color: AppColor.primaryDarkColor,
          padding: EdgeInsets.only(
              bottom: Sizes.dimen_8.h,
              right: Sizes.dimen_4.w,
              left: Sizes.dimen_4.w),
          child: Row(
            children: [
              if (iconData != null)
                Icon(
                  iconData,
                  color: AppColor.white,
                ),
              if (svgImage != null)
                SvgPicture.asset(svgImage!,
                    height: imgSize ?? Sizes.dimen_30.w,
                    width: imgSize ?? Sizes.dimen_30.w,
                    color: imgColor,
                    semanticsLabel: ''),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_20.w),
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
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
