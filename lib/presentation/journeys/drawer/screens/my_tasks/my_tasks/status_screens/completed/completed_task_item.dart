import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/widgetExtension.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/presentation/widgets/image_name_rating_widget.dart';

import '../../../../../../../../common/constants/app_utils.dart';
import '../../../../../../../../common/constants/sizes.dart';
import '../../../../../../../../common/enum/animation_type.dart';
import '../../../../../../../themes/theme_color.dart';
import '../../../../../../../widgets/rounded_text.dart';
import '../../../../../../../widgets/text_with_icon.dart';

class CompletedTaskItem extends StatelessWidget {
  final TaskEntity taskEntity;

  const CompletedTaskItem({Key? key, required this.taskEntity}) : super(key: key);

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                taskEntity.title,
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

                              /// date, court, applicants
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

                                    SizedBox(width: Sizes.dimen_8.w),

                                    /// applicantsCount
                                    TextWithIconWidget(
                                      iconData: Icons.person_outline_outlined,
                                      text:
                                      taskEntity.applicantsCount.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// lawyer img
                      ImageNameRatingWidget(
                        imgUrl: taskEntity.creatorImage,
                        name: taskEntity.creatorName,
                        rating: taskEntity.creatorRating.toDouble(),
                        nameColor: AppColor.primaryDarkColor,
                        ratedColor: AppColor.accentColor,
                        unRatedColor: AppColor.primaryColor,
                        withRow: false,
                        onPressed: () {},
                      ),
                    ],
                  ),

                  /// price, startChat
                  Row(
                    children: [
                      ///==> price
                      Flexible(
                        child: RoundedText(
                          text: "${taskEntity.price} جنيه مصرى",
                          background: AppColor.accentColor,
                          textSize: Sizes.dimen_10,
                        ),
                      ),

                      ///==> file
                      Flexible(
                        child: RoundedText(
                          text: "ملف المهمة",
                          rightIconData: Icons.file_copy_rounded,
                          textSize: Sizes.dimen_10,
                          onPressed: () {},
                        ),
                      ),

                      ///==> file
                      Flexible(
                        child: RoundedText(
                          text: "مهمة مكتملة",
                          rightIconData: Icons.done_outline,
                          textSize: Sizes.dimen_10,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
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
}
