import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/app_utils.dart';
import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';
import 'app_logo.dart';

class CustomAppBar extends PreferredSize {
  final BuildContext context;
  final Function() onMenuPressed;
  final Function() onSearchPressed;

  CustomAppBar({
    Key? key,
    required this.context,
    required this.onMenuPressed,
    required this.onSearchPressed
  }) : super(
          key: key,
          preferredSize: Size.fromHeight(Sizes.dimen_80.h),
          child: Container(
            color: AppColor.primaryDarkColor,
            child: Padding(
              padding: EdgeInsets.only(
                  top: Sizes.dimen_10.h, bottom: Sizes.dimen_3.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// Icon menu
                  Container(
                    margin: EdgeInsets.only(
                      top: Sizes.dimen_12.h,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: AppColor.white,
                        //size: Sizes.dimen_100.w,
                      ),
                      onPressed: onMenuPressed,
                    ),
                  ),

                  /// search
                  Expanded(
                    child: GestureDetector(
                      onTap: onSearchPressed,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: Sizes.dimen_12.h,
                          //left: Sizes.dimen_3.w,
                          //right: Sizes.dimen_10.w,
                        ),
                        padding: EdgeInsets.symmetric(vertical: Sizes.dimen_10.w),
                        // constraints: BoxConstraints(maxHeight: Sizes.dimen_22.h),
                        //height: Sizes.dimen_18.h,
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
                              Expanded(
                                child: Text(
                                  "يامتر ابحث عن محامى فى محافظة.. ؟",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: AppColor.white),
                                ),
                              ),
                              const Icon(
                                Icons.search_outlined,
                                color: AppColor.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// AppLogo
                  AppLogo(
                    size: Sizes.dimen_100.w,
                  ),
                ],
              ),
            ),
          ),
        );

}
