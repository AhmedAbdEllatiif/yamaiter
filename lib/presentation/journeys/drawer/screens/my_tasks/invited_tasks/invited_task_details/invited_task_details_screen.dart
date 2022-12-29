import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/apply_for_task_args.dart';
import 'package:yamaiter/presentation/logic/cubit/apply_for_task/apply_for_task_cubit.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../../../../common/constants/app_utils.dart';
import '../../../../../../../common/constants/sizes.dart';
import '../../../../../../../domain/entities/screen_arguments/invite_task_details_args.dart';
import '../../../../../../themes/theme_color.dart';
import '../../../../../../widgets/app_content_title_widget.dart';
import '../../../../../../widgets/image_name_rating_widget.dart';
import '../../../../../../widgets/rounded_text.dart';
import '../../../../../../widgets/scrollable_app_card.dart';
import '../../../../../../widgets/ads_widget.dart';
import '../../../../../../widgets/text_with_icon.dart';

class InvitedTaskDetailsScreen extends StatefulWidget {
  final InvitedTaskDetailsArguments arguments;

  const InvitedTaskDetailsScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<InvitedTaskDetailsScreen> createState() =>
      _InvitedTaskDetailsScreenState();
}

class _InvitedTaskDetailsScreenState extends State<InvitedTaskDetailsScreen> {
  late final TaskEntity _taskEntity;
  late final LawyerEntity _recommenderEntity;
  late final ApplyForTaskCubit _applyForTaskCubit;

  @override
  void initState() {
    super.initState();
    _taskEntity = widget.arguments.taskEntity;
    _recommenderEntity = widget.arguments.taskEntity.recommenderLawyer;
    _applyForTaskCubit = widget.arguments.applyForTaskCubit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appbar
      appBar: AppBar(
        title: const Text("تفاصيل المهمة"),
      ),

      /// body
      body: BlocListener<ApplyForTaskCubit, ApplyForTaskState>(
        bloc: _applyForTaskCubit,
        listener: (context, state) {
          Navigator.pop(context);
        },
        child: Column(
          children: [
            /// Ads ListView
            const AdsWidget(),

            /// space
            const SizedBox(
              height: 10,
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                                    title: _taskEntity.title,
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
                                            text: _taskEntity.governorates,
                                          ),
                                        ),

                                        SizedBox(width: Sizes.dimen_8.w),

                                        /// date
                                        Flexible(
                                          child: TextWithIconWidget(
                                            iconData: Icons.date_range_outlined,
                                            text: _taskEntity.startingDate,
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
                                            text: _taskEntity.court,
                                          ),
                                        ),

                                        SizedBox(width: Sizes.dimen_8.w),
                                        //==> applicantsCount
                                        TextWithIconWidget(
                                          iconData: Icons.person_outline_outlined,
                                          text: _taskEntity.applicantsCount
                                              .toString(),
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
                        ImageNameRatingWidget(
                          imgUrl: _recommenderEntity.profileImage,
                          name: _recommenderEntity.firstName,
                          rating: _recommenderEntity.rating.toDouble(),
                          nameColor: AppColor.primaryDarkColor,
                          ratedColor: AppColor.accentColor,
                          unRatedColor: AppColor.primaryColor,
                          minImageSize: Sizes.dimen_40,
                          maxImageSize: Sizes.dimen_48,
                          withRow: false,
                          onPressed: () {},
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
                              text: "${_taskEntity.price} جنيه مصرى",
                              background: AppColor.accentColor,
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.dimen_10,
                                horizontal: Sizes.dimen_15,
                              ),
                            ),

                            //==> apply for the task
                            RoundedText(
                              text: "تقدم للمهمة",
                              background: AppColor.primaryDarkColor,
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.dimen_10,
                                horizontal: Sizes.dimen_15,
                              ),
                              onPressed: () {
                                _navigateToApplyForTask();
                              },
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
                          _taskEntity.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToApplyForTask() {
    RouteHelper().applyForTask(
      context,
      applyForTaskArguments: ApplyForTaskArguments(
        taskEntity: _taskEntity,
        applyForTaskCubit: widget.arguments.applyForTaskCubit,
      ),
    );
  }
}
