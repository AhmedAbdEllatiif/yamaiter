import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/app_utils.dart';
import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';
import 'app_logo.dart';

class CustomAppBar extends PreferredSize{
  final BuildContext context;
  CustomAppBar(this.context, {Key? key}):super(key: key,
    preferredSize: Size.fromHeight(Sizes.dimen_80.h),
    child: Container(
      color: AppColor.primaryDarkColor,
      child: Padding(
        padding: EdgeInsets.only(
            top: Sizes.dimen_10.h, bottom: Sizes.dimen_3.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // AppLogo
            AppLogo(
              size: Sizes.dimen_100.w,
            ),

            // search
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    top: Sizes.dimen_12.h,
                    left: Sizes.dimen_15.w,
                    right: Sizes.dimen_10.w),
                constraints: BoxConstraints(maxHeight: Sizes.dimen_22.h),
                height: Sizes.dimen_18.h,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  border: Border.all(color: Colors.transparent),
                  borderRadius:
                  BorderRadius.circular(AppUtils.cornerRadius.w),
                ),
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: Sizes.dimen_12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ابحث عن محامى.. ؟",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppColor.white),
                      ),
                      const Icon(
                        Icons.search_outlined,
                        color: AppColor.white,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );



}