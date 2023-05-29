import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';

import '../../../../common/constants/app_utils.dart';
import '../../../../common/constants/sizes.dart';
import '../../../../common/functions/call_someone.dart';
import '../../../themes/theme_color.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/image_name_rating_widget.dart';
import '../../../widgets/scrollable_app_card.dart';

class SingleSosDetailsWidget extends StatelessWidget {
  final SosEntity sosEntity;
  final bool withCallButton;

  const SingleSosDetailsWidget({
    Key? key,
    required this.sosEntity,
    required this.withCallButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(
          top: Sizes.dimen_10.h,
          bottom: AppUtils.mainPagesVerticalPadding.h,
          right: AppUtils.mainPagesHorizontalPadding.w,
          left: AppUtils.mainPagesHorizontalPadding.w,
        ),
        child: ScrollableAppCard(

            /// title and avatar
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sosEntity.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColor.primaryDarkColor,
                            fontWeight: FontWeight.bold,
                            height: 1.2),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.date_range_outlined,
                            color: AppColor.accentColor,
                            size: Sizes.dimen_12.w,
                          ),
                          Text(
                            sosEntity.createdAtString,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: AppColor.accentColor),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                // ImageNameRatingWidget
                ImageNameRatingWidget(
                  name: sosEntity.creatorName,
                  imgUrl: sosEntity.creatorImage,
                  rating: sosEntity.creatorRating.toDouble(),
                  unRatedColor: AppColor.primaryColor.withOpacity(0.6),
                  withRow: false,
                  nameSize: Sizes.dimen_12.sp,
                  iconRateSize: Sizes.dimen_12,
                  minImageSize: Sizes.dimen_40.w,
                  maxImageSize: Sizes.dimen_40.w,
                  nameColor: AppColor.primaryDarkColor,
                  onPressed: () {
                    // RouteHelper().editProfile(context);
                  },
                ),
              ],
            ),

            /// bottom
            bottomChild: withCallButton
                ? AppButton(
                    text: "اتصل بالمحامى",
                    textColor: AppColor.accentColor,
                    color: AppColor.primaryDarkColor,
                    fontSize: Sizes.dimen_12.sp,
                    icon: Icon(
                      Icons.call_outlined,
                      color: AppColor.accentColor,
                      size: Sizes.dimen_16.w,
                    ),
                    onPressed: () =>
                        callSomeone(phoneNunm: sosEntity.creatorPhoneNum),
                  )
                : null,

            /// child
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// description
                Text(
                  sosEntity.description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black, height: 1.4),
                ),
              ],
            )),
      ),
    );
  }
}
