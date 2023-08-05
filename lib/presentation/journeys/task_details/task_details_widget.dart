import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/presentation/logic/cubit/apply_for_task/apply_for_task_cubit.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/sizes.dart';
import '../../../common/enum/user_type.dart';
import '../../../domain/entities/screen_arguments/apply_for_task_args.dart';
import '../../../router/route_helper.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_content_title_widget.dart';
import '../../widgets/image_name_rating_widget.dart';
import '../../widgets/rounded_text.dart';
import '../../widgets/scrollable_app_card.dart';
import '../../widgets/text_with_icon.dart';

class TaskDetailsWidget extends StatelessWidget {
  final ApplyForTaskCubit applyForTaskCubit;
  final TaskEntity taskEntity;

  const TaskDetailsWidget({
    Key? key,
    required this.applyForTaskCubit,
    required this.taskEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppUtils.mainPagesHorizontalPadding.w,
        ),
        child: ScrollableAppCard(
          /// card title
          title: Row(
            children: [
              //==> title, date, court
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// title
                    Row(
                      children: [
                        Expanded(
                            child: AppContentTitleWidget(
                          title: taskEntity.title,
                          textSpace: 1.3,
                        )),
                      ],
                    ),

                    /// date, court, applicants
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 3, right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// governorates
                          Row(
                            children: [
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

                          const SizedBox(height: 3),

                          /// court, applicantsCount
                          Row(
                            children: [
                              //==> court
                              Flexible(
                                child: TextWithIconWidget(
                                  iconData: Icons.home_outlined,
                                  text: taskEntity.court,
                                ),
                              ),

                              SizedBox(width: Sizes.dimen_8.w),
                              //==> applicantsCount
                              TextWithIconWidget(
                                iconData: Icons.person_outline_outlined,
                                text: taskEntity.applicantsCount.toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// img, rating
              Column(
                children: [
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
                  if (taskEntity.creatorType != UserType.unDefined)
                    Text(
                      taskEntity.creatorType == UserType.client
                          ? "زائر"
                          : "محامى",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColor.black.withOpacity(0.6), height: 1.2),
                    ),
                ],
              ),
            ],
          ),

          /// bottomChild
          bottomChild: Row(
            children: [
              Row(
                children: [
                  //==> price
                  RoundedText(
                    text: "${taskEntity.price} جنيه مصرى",
                    background: AppColor.accentColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.dimen_10,
                      horizontal: Sizes.dimen_15,
                    ),
                  ),

                  if (!taskEntity.alreadyApplied)
                    //==> apply for the task
                    RoundedText(
                      text: "تقدم للمهمة",
                      background: AppColor.primaryDarkColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.dimen_10,
                        horizontal: Sizes.dimen_15,
                      ),
                      onPressed: () {
                        _navigateToApplyForTask(context);
                      },
                    ),
                  if (taskEntity.alreadyApplied)
                     RoundedText(
                      text: "تقدمت بالفعل",
                      background: AppColor.green,
                      leftIconData: Icons.done_outline_outlined,
                      leftIconColor: AppColor.white,
                      textColor: AppColor.white,
                      onPressed: (){
                        RouteHelper().appliedTasksScreen(context);
                      },
                      padding: EdgeInsets.symmetric(
                        vertical: Sizes.dimen_10,
                        horizontal: Sizes.dimen_15,
                      ),
                    ),
                ],
              ),
            ],
          ),

          /// child
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //==> description
              Text(
                taskEntity.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black, height: 1.4),
              ),

              //==> space
              SizedBox(
                height: Sizes.dimen_10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToApplyForTask(BuildContext context) {
    RouteHelper().applyForTask(
      context,
      applyForTaskArguments: ApplyForTaskArguments(
        taskEntity: taskEntity,
        applyForTaskCubit: applyForTaskCubit,
      ),
    );
  }
}
