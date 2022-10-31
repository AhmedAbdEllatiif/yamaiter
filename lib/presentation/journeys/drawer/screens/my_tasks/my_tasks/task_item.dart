import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/widgetExtension.dart';

import '../../../../../../common/constants/app_utils.dart';
import '../../../../../../common/constants/sizes.dart';
import '../../../../../../common/enum/animation_type.dart';
import '../../../../../themes/theme_color.dart';
import '../../../../../widgets/cached_image_widget.dart';
import '../../../../../widgets/card_menu_item.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({Key? key}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _isMenuOpened = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          //==> close menu if opened
          if (_isMenuOpened) {
            setState(() {
              _isMenuOpened = !_isMenuOpened;
            });
          } else {
            // _navigateToArticleDetailsScreen();
          }
        },
        borderRadius: BorderRadius.circular(AppUtils.cornerRadius),
        child: Padding(
          padding: EdgeInsets.only(
              left: Sizes.dimen_8.w,
              right: Sizes.dimen_8.w,
              bottom: Sizes.dimen_8.h),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: Sizes.dimen_10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// data
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: Sizes.dimen_4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// title
                            Text(
                              "widget.articleEntity.title",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    height: 3,
                                  ),
                            ),

                            /// description
                            Text(
                              "widget.articleEntity.description",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    height: 1.3,
                                  ),
                            ),

                            /// date
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.date_range_outlined,
                                  color: AppColor.accentColor,
                                  size: Sizes.dimen_12.w,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 3),
                                  child: Text(
                                    " widget.articleEntity.createdAt",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: AppColor.accentColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// price
                    Container(
                      margin: EdgeInsets.only(
                        left: Sizes.dimen_10.w,
                        top: Sizes.dimen_10,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.dimen_3,
                        horizontal: Sizes.dimen_15,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.accentColor,
                        borderRadius: BorderRadius.circular(
                          AppUtils.cornerRadius.w,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "500 جنيه مصرى",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              /// menu dots
              //if (widget.withMenu)
              Positioned(
                top: 0.0,
                left: Sizes.dimen_10.w,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isMenuOpened = !_isMenuOpened;
                    });
                  },
                  child: Text(
                    "...",
                    style: TextStyle(
                        fontSize: Sizes.dimen_20.sp,
                        color: AppColor.primaryDarkColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              /// menu
              if (_isMenuOpened /*&& widget.withMenu*/)
                Positioned(
                  top: Sizes.dimen_30,
                  left: Sizes.dimen_10.w,
                  child: Container(
                    padding: EdgeInsets.all(Sizes.dimen_5.w),
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(color: AppColor.primaryDarkColor)),
                    child: Column(
                      children: [
                        CardMenuItem(
                          text: "تعديل النشور",
                          onPressed: () => {},
                        ),
                        CardMenuItem(
                          text: "حذف االمنشور",
                          onPressed: () => {},
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ).animate(
        slideDuration: const Duration(milliseconds: 300),
        fadeDuration: const Duration(milliseconds: 300),
        map: {
          AnimationType.slide: {
            SlideOffset.begin: const Offset(0.0, 0.5),
            SlideOffset.end: const Offset(0.0, 0.0),
          },
          AnimationType.fade: {
            FadeOpacity.begin: 0.5,
            FadeOpacity.end: 1.0,
          },
        });
  }
}
