import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/task_details_args.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/sizes.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_content_title_widget.dart';
import '../../widgets/image_name_rating_widget.dart';
import '../../widgets/rounded_text.dart';
import '../../widgets/scrollable_app_card.dart';
import '../../widgets/ads_widget.dart';
import '../../widgets/text_with_icon.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TaskDetailsArguments taskDetailsArguments;

  const TaskDetailsScreen({Key? key, required this.taskDetailsArguments})
      : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late final TaskEntity _taskEntity;

  @override
  void initState() {
    super.initState();
    _taskEntity = widget.taskDetailsArguments.taskEntity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appbar
      appBar: AppBar(
        title: const Text("تفاصيل المهمة"),
      ),

      /// body
      body: Column(
        children: [
          /// Ads ListView
          const AdsWidget(),

          /// space
          const SizedBox(
            height: 10,
          ),

          Padding(
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
                                    text:
                                        _taskEntity.applicantsCount.toString(),
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
                    imgUrl: _taskEntity.creatorImage,
                    name: _taskEntity.creatorName,
                    rating: _taskEntity.creatorRating.toDouble(),
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
                      ),
                      //==> apply for the task
                      RoundedText(
                        text: "تقدم للمهمة",
                        background: AppColor.primaryDarkColor,
                        onPressed: () {},
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
        ],
      ),
    );
  }
}
