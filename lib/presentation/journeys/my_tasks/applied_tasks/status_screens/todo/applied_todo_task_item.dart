import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/widget_extension.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/task_details_args.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../../../../../common/constants/app_utils.dart';
import '../../../../../../../../common/constants/sizes.dart';
import '../../../../../../../../common/enum/animation_type.dart';
import '../../../../../themes/theme_color.dart';
import '../../../../../widgets/image_name_rating_widget.dart';
import '../../../../../widgets/rounded_text.dart';
import '../../../../../widgets/text_with_icon.dart';

class AppliedTodoTaskItem extends StatelessWidget {
  final TaskEntity taskEntity;

  const AppliedTodoTaskItem({
    Key? key,
    required this.taskEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: ScreenUtil.screenHeight * 0.15),
      child: Card(
        child: InkWell(
          onTap: null,
          borderRadius: BorderRadius.circular(AppUtils.cornerRadius),
          child: Padding(
            padding: EdgeInsets.only(
                left: Sizes.dimen_8.w,
                right: Sizes.dimen_8.w,
                bottom: Sizes.dimen_8.h),
            child: Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_10.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// img, rating
                      ImageNameRatingWidget(
                        imgUrl: taskEntity.creatorImage,
                        name: taskEntity.creatorName,
                        rating: taskEntity.creatorRating.toDouble(),
                        nameColor: AppColor.primaryDarkColor,
                        ratedColor: AppColor.accentColor,
                        unRatedColor: AppColor.primaryColor,
                        minImageSize: Sizes.dimen_40,
                        maxImageSize: Sizes.dimen_48,
                        withRow: false,
                        onPressed: () {},
                      ),

                      /// data
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: Sizes.dimen_4.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// title
                              Text(
                                taskEntity.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
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
                                taskEntity.description,
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

                              /// date, court
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.only(top: 10, right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    /// court
                                    Flexible(
                                      child: TextWithIconWidget(
                                        iconData: Icons.pin_drop_outlined,
                                        text: taskEntity.governorates,
                                      ),
                                    ),

                                    SizedBox(width: Sizes.dimen_8.w),

                                    /// date
                                    Flexible(
                                      child: TextWithIconWidget(
                                        iconData: Icons.date_range_outlined,
                                        text: taskEntity.startingDate,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// price
                              RoundedText(
                                text: "${taskEntity.price} جنيه مصرى",
                                background: AppColor.accentColor,
                              ),

                              /// apply, readMore
                              /* Row(
                                children: [
                                  //==> apply for the task
                                  RoundedText(
                                    text: "تقدم للمهمة",
                                    background: AppColor.primaryDarkColor,
                                    onPressed: () {},
                                  ),

                                  //==> readMore
                                  RoundedText(
                                    text: "المزيد عن المهمة",
                                    background: AppColor.primaryDarkColor,
                                    onPressed: () {},
                                  ),
                                ],
                              )*/
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //==> apply for the task
                      /*RoundedText(
                                text: "تقدم للمهمة",
                                background: AppColor.primaryDarkColor,
                                onPressed: () {},
                              ),*/

                      //==> readMore
                      RoundedText(
                        text: "المزيد عن المهمة",
                        background: AppColor.primaryDarkColor,
                        leftIconData: Icons.keyboard_double_arrow_left,
                        onPressed: () => _navigateToTaskDetails(context),
                      ),
                    ],
                  )
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

  void _navigateToTaskDetails(BuildContext context) {
    RouteHelper().taskDetails(context,
        taskDetailsArguments: TaskDetailsArguments(
          taskId: taskEntity.id,
          isAlreadyApplied: true,
        ));
  }
}
