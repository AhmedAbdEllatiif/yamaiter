import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/widgetExtension.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/edit_task_args.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../../../../../common/constants/app_utils.dart';
import '../../../../../../../../common/constants/sizes.dart';
import '../../../../../../../../common/enum/animation_type.dart';
import '../../../../../../../themes/theme_color.dart';
import '../../../../../../../widgets/cached_image_widget.dart';
import '../../../../../../../widgets/card_menu_item.dart';
import '../../../../../../../widgets/rounded_text.dart';
import '../../../../../../../widgets/text_with_icon.dart';

class TodoTaskItem extends StatefulWidget {
  final TaskEntity taskEntity;
  final Function() onUpdatePressed;
  final Function() onDeletePressed;

  const TodoTaskItem({
    Key? key,
    required this.taskEntity,
    required this.onUpdatePressed,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  State<TodoTaskItem> createState() => _TodoTaskItemState();
}

class _TodoTaskItemState extends State<TodoTaskItem> {
  bool _isMenuOpened = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: ScreenUtil.screenHeight * 0.15),
      child: Card(
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
                                widget.taskEntity.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      height: 1.5,
                                    ),
                              ),

                              SizedBox(
                                height: Sizes.dimen_2.h,
                              ),

                              /// description
                              Text(
                                widget.taskEntity.description,
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

                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(top: 20, right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    /// court
                                    Flexible(
                                      child: TextWithIconWidget(
                                        iconData: Icons.pin_drop_outlined,
                                        text: widget.taskEntity.governorates,
                                      ),
                                    ),

                                    SizedBox(width: Sizes.dimen_8.w),

                                    /// date
                                    Flexible(
                                      child: TextWithIconWidget(
                                        iconData: Icons.date_range_outlined,
                                        text: widget.taskEntity.startingDate,
                                      ),
                                    ),

                                    SizedBox(width: Sizes.dimen_8.w),

                                    /// applicantsCount
                                    TextWithIconWidget(
                                      iconData: Icons.person_outline_outlined,
                                      text: widget.taskEntity.applicantsCount
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// price
                      RoundedText(
                        text:  "${widget.taskEntity.price} جنيه مصرى",
                        background: AppColor.accentColor,
                      ),
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
                            onPressed: widget.onUpdatePressed,
                          ),
                          CardMenuItem(
                            text: "حذف االمنشور",
                            onPressed: widget.onDeletePressed,
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
          }),
    );
  }
}
