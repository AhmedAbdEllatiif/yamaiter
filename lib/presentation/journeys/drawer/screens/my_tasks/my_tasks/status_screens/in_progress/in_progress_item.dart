import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/widgetExtension.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/edit_task_args.dart';
import 'package:yamaiter/presentation/widgets/image_name_rating_widget.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../../../../../common/constants/app_utils.dart';
import '../../../../../../../../common/constants/sizes.dart';
import '../../../../../../../../common/enum/animation_type.dart';
import '../../../../../../../themes/theme_color.dart';
import '../../../../../../../widgets/cached_image_widget.dart';
import '../../../../../../../widgets/card_menu_item.dart';
import '../../../../../../../widgets/rounded_text.dart';
import '../../../../../../../widgets/text_with_icon.dart';

class InProgressTaskItem extends StatefulWidget {
  final TaskEntity taskEntity;

  const InProgressTaskItem({
    Key? key,
    required this.taskEntity,
  }) : super(key: key);

  @override
  State<InProgressTaskItem> createState() => _InProgressTaskItemState();
}

class _InProgressTaskItemState extends State<InProgressTaskItem> {
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
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Sizes.dimen_10.h),
                  child: Row(
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

                              /// price, startChat
                              Row(
                                children: [
                                  ///==> price
                                  Flexible(
                                    child: RoundedText(
                                      text:
                                          "${widget.taskEntity.price} جنيه مصرى",
                                      background: AppColor.accentColor,
                                    ),
                                  ),

                                  ///==> start chat
                                  Flexible(
                                    child: RoundedText(
                                      text: "ابدأ المحادثة",
                                      rightIconData: Icons.chat_bubble_outline,
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      ImageNameRatingWidget(
                        imgUrl: widget.taskEntity.creatorImage,
                        name: widget.taskEntity.creatorName,
                        rating: widget.taskEntity.creatorRating.toDouble(),
                        nameColor: AppColor.primaryDarkColor,
                        ratedColor: AppColor.accentColor,
                        unRatedColor: AppColor.primaryColor,
                        withRow: false,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                /// menu dots
                //if (widget.withMenu)
                Positioned(
                  top: Sizes.dimen_10.w,
                  left: Sizes.dimen_6.w,
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.clear,
                      size: Sizes.dimen_20.w,
                      color: AppColor.primaryDarkColor.withOpacity(
                        0.6,
                      ),
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
