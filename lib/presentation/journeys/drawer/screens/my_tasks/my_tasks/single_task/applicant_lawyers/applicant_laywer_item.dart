import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/common_functions.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';
import 'package:yamaiter/presentation/logic/cubit/assign_task/assign_task_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../../../../../../common/constants/app_utils.dart';
import '../../../../../../../../common/constants/assets_constants.dart';
import '../../../../../../../../common/constants/sizes.dart';
import '../../../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../../../widgets/cached_image_widget.dart';
import '../../../../../../../widgets/rounded_text.dart';

class ApplicantLawyerItem extends StatelessWidget {
  final LawyerEntity lawyerEntity;
  final Function() onAssignPressed;
  final AssignTaskCubit assignTaskCubit;

  const ApplicantLawyerItem({
    Key? key,
    required this.lawyerEntity,
    required this.onAssignPressed,
    required this.assignTaskCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocConsumer<AssignTaskCubit, AssignTaskState>(
        bloc: assignTaskCubit,
        listener: (context, state) {
          if (state is ErrorWhileAssigningTask) {
            showSnackBar(
              context,
              message: "Something went wrong, try again",
              backgroundColor: AppColor.primaryDarkColor,
              textColor: AppColor.primaryDarkColor,
            );
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
                color: state is LoadingAssignTask
                    ? AppColor.primaryDarkColor.withOpacity(0.6)
                    : null),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Stack(
                children: [
                  Row(
                    children: [
                      /// image
                      CachedImageWidget(
                        imageUrl:
                            lawyerEntity.profileImage == AppUtils.undefined
                                ? AssetsImages.personAvatar
                                : lawyerEntity.profileImage,
                        isCircle: true,
                        height: Sizes.dimen_40.w,
                        width: Sizes.dimen_40.w,
                        progressBarScale: 0.5,
                      ),

                      /// space
                      const SizedBox(
                        width: 10,
                      ),

                      /// name , rate , description
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //==> name
                            Text(
                              lawyerEntity.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: AppColor.primaryDarkColor,
                                      height: 1.2),
                            ),

                            //==> rating , taskCount
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBar.builder(
                                  initialRating: lawyerEntity.rating.toDouble(),
                                  minRating: 0.5,
                                  itemSize: Sizes.dimen_12.w,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  unratedColor: AppColor.primaryColor,
                                  ignoreGestures: true,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: AppColor.primaryColor,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),

                                // space
                                const SizedBox(
                                  width: 5,
                                ),

                                // task count
                                Text(
                                  "${lawyerEntity.tasksCount} مهمة ",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: AppColor.primaryDarkColor,
                                          height: 1.3),
                                ),
                              ],
                            ),

                            /// space
                            const SizedBox(
                              height: 5,
                            ),

                            //==> description
                            Text(
                              lawyerEntity.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: AppColor.primaryDarkColor,
                                      height: 1.3),
                            ),
                          ],
                        ),
                      ),

                      /// price, assign task
                      Row(
                        children: [
                          Column(
                            children: [
                              ///==> price
                              RoundedText(
                                text: "${-1} جنيه مصرى",
                                background: AppColor.accentColor,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      height: 1.2,
                                      fontSize: Sizes.dimen_12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),

                              ///==> assign task
                              RoundedText(
                                text: "اسناد المهمة",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        height: 1.2,
                                        fontSize: Sizes.dimen_12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.accentColor),
                                onPressed: onAssignPressed,
                              ),
                            ],
                          ),
                        ],
                      ),
                      //Text(lawyerEntity.name),
                    ],
                  ),

                  /// loading
                  if (state is LoadingAssignTask)
                    const Center(
                        child: LoadingWidget(
                      size: 50,
                    )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
