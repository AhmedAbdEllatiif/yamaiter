import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/widgetExtension.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/edit_task_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/task_details_args.dart';
import 'package:yamaiter/presentation/widgets/image_name_rating_widget.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../common/constants/app_utils.dart';
import '../../../../common/constants/sizes.dart';
import '../../../../common/enum/animation_type.dart';
import '../themes/theme_color.dart';
import 'cached_image_widget.dart';
import 'card_menu_item.dart';
import 'text_with_icon.dart';

class TaskItem extends StatefulWidget {
  final TaskEntity taskEntity;

  const TaskItem({
    Key? key,
    required this.taskEntity,
  }) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: ScreenUtil.screenHeight * 0.15),
      child: Card(
        child: InkWell(
          onTap: () {
            _navigateToTaskDetailsScreen();
          },
          borderRadius: BorderRadius.circular(AppUtils.cornerRadius),
          child: Padding(
            padding: EdgeInsets.only(
                left: Sizes.dimen_8.w,
                right: Sizes.dimen_8.w,
                bottom: Sizes.dimen_8.h),
            child: Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_10.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ImageNameRatingWidget(
                              imgUrl: widget.taskEntity.creatorImage,
                              name: widget.taskEntity.creatorName,
                              rating:
                                  widget.taskEntity.creatorRating.toDouble(),
                              withRow: false,
                              nameColor: AppColor.primaryDarkColor,
                              ratedColor: AppColor.accentColor,
                              unRatedColor: AppColor.primaryColor,
                              minImageSize: Sizes.dimen_40,
                              maxImageSize: Sizes.dimen_50,
                              onPressed: () {},
                            ),

                            /// data
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: Sizes.dimen_4.w),
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

                                    /// price
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
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
                                              "${widget.taskEntity.price}  جنيه مصرى",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        Center(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 20, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /// court
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWithIconWidget(
                                        iconData: Icons.pin_drop_outlined,
                                        iconSize: Sizes.dimen_16.w,
                                        text: widget.taskEntity.governorates,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              color: AppColor.accentColor,
                                              height: 1.3,
                                            ),
                                      ),
                                      SizedBox(height: Sizes.dimen_8.w),
                                      TextWithIconWidget(
                                        iconData: Icons.house_outlined,
                                        iconSize: Sizes.dimen_16.w,
                                        text: widget.taskEntity.court,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              color: AppColor.accentColor,
                                              height: 1.3,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: Sizes.dimen_20.w),

                                /// date
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWithIconWidget(
                                        iconData: Icons.date_range_outlined,
                                        iconSize: Sizes.dimen_16.w,
                                        text: widget.taskEntity.startingDate,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              color: AppColor.accentColor,
                                              height: 1.3,
                                            ),
                                      ),

                                      SizedBox(height: Sizes.dimen_8.w),

                                      /// applicantsCount
                                      TextWithIconWidget(
                                        iconData: Icons.person_outline_outlined,
                                        iconSize: Sizes.dimen_16.w,
                                        text:
                                            "${widget.taskEntity.applicantsCount} متقدمون "
                                                .toString(),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              color: AppColor.accentColor,
                                              height: 1.3,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// price
                        /* Container(
                          margin: EdgeInsets.only(
                            left: Sizes.dimen_10.w,
                            top: Sizes.dimen_10,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.dimen_3,
                            horizontal: Sizes.dimen_15,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.primaryDarkColor,
                            borderRadius: BorderRadius.circular(
                              AppUtils.cornerRadius.w,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "تقدم للمهمة",
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.accentColor),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                  const RotatedBox(
                      quarterTurns: 2,
                      child: Icon(Icons.double_arrow_outlined)),
                ],
              ),
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

  /// to navigate to TaskDetailsScreen
  void _navigateToTaskDetailsScreen() {
    RouteHelper().taskDetails(context,
        taskDetailsArguments: TaskDetailsArguments(
          taskEntity: widget.taskEntity,
          isAlreadyApplied: false,
        ));
  }
}
