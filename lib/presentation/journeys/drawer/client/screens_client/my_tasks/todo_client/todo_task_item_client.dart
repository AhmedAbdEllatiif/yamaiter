import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/widgetExtension.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';

import '../../../../../../../../common/constants/app_utils.dart';
import '../../../../../../../../common/constants/sizes.dart';
import '../../../../../../../../common/enum/animation_type.dart';
import '../../../../../../themes/theme_color.dart';
import '../../../../../../widgets/rounded_text.dart';
import '../../../../../../widgets/text_with_icon.dart';

class TodoTaskItemClient extends StatefulWidget {
  final TaskEntity taskEntity;
  final Function() onUpdatePressed;
  final Function() onDeletePressed;
  final Function() onPressed;

  const TodoTaskItemClient({
    Key? key,
    required this.taskEntity,
    required this.onUpdatePressed,
    required this.onDeletePressed,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<TodoTaskItemClient> createState() => _TodoTaskItemClientState();
}

class _TodoTaskItemClientState extends State<TodoTaskItemClient> {
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
              widget.onPressed();
            }
          },
          borderRadius: BorderRadius.circular(AppUtils.cornerRadius),
          child: Padding(
            padding: EdgeInsets.only(
                left: Sizes.dimen_8.w,
                right: Sizes.dimen_8.w,
                bottom: Sizes.dimen_8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PopupMenuButton(
                    // add icon, by default "3 dot" icon
                    // icon: Icon(Icons.book)
                    itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("تعديل المهمة"),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("حذف المهمة"),
                    ),
                  ];
                }, onSelected: (value) {
                  if (value == 0) {
                    widget.onUpdatePressed();
                  } else if (value == 1) {
                    widget.onDeletePressed();
                  }
                }),
                Row(
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
                      text: "${widget.taskEntity.price} جنيه مصرى",
                      background: AppColor.accentColor,
                    ),
                  ],
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
