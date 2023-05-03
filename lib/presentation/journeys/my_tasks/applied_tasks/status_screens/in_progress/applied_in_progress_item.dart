import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/widget_extension.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/presentation/widgets/image_name_rating_widget.dart';
import 'package:yamaiter/presentation/widgets/start_chat_button.dart';

import '../../../../../../../../common/constants/app_utils.dart';
import '../../../../../../../../common/constants/sizes.dart';
import '../../../../../../../../common/enum/animation_type.dart';
import '../../../../../themes/theme_color.dart';
import '../../../../../widgets/rounded_text.dart';
import '../../../../../widgets/text_with_icon.dart';

class AppliedInProgressItem extends StatefulWidget {
  final TaskEntity taskEntity;
  final Function() onUploadFileClicked;

  const AppliedInProgressItem({
    Key? key,
    required this.taskEntity,
    required this.onUploadFileClicked,
  }) : super(key: key);

  @override
  State<AppliedInProgressItem> createState() => _AppliedInProgressItemState();
}

class _AppliedInProgressItemState extends State<AppliedInProgressItem> {
  @override
  Widget build(BuildContext context) {
    log("ChatId >> ${widget.taskEntity.chatId}");
    log("ChatId >> ${widget.taskEntity.chatChannel}");
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
                                padding: const EdgeInsets.only(top: 20, right: 5),
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
                    ],
                  ),

                  /// price, startChat
                  Row(
                    children: [
                      ///==> price
                      Flexible(
                        child: RoundedText(
                          text: "${widget.taskEntity.price} جنيه مصرى",
                          background: AppColor.accentColor,
                        ),
                      ),

                      ///==> start chat
                      Flexible(
                        child: StartChatButton(
                          chatChannel: widget.taskEntity.chatChannel,
                          chatRoomId: widget.taskEntity.chatId,
                        ),
                      ),

                      ///==> attach file
                      Flexible(
                        child: RoundedText(
                          text: "ارفق الملف",
                          rightIconData: Icons.upload_file_outlined,
                          onPressed: widget.onUploadFileClicked,
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
