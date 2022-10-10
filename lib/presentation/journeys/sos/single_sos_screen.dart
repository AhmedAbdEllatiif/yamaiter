import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_sos_screen_args.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/ads_widget.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/image_name_rating_widget.dart';
import 'package:yamaiter/presentation/widgets/scrollable_app_card.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/assets_constants.dart';
import '../../../common/constants/sizes.dart';
import '../../../domain/entities/data/ad_entity.dart';
import '../../widgets/ads_list/ads_list_view.dart';

class SingleSosScreen extends StatefulWidget {
  final SingleScreenArguments singleScreenArguments;

  const SingleSosScreen({Key? key, required this.singleScreenArguments})
      : super(key: key);

  @override
  State<SingleSosScreen> createState() => _SingleSosScreenState();
}

class _SingleSosScreenState extends State<SingleSosScreen> {
  late SosEntity sosEntity;

  @override
  void initState() {
    super.initState();
    sosEntity = widget.singleScreenArguments.sosEntity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("استغاثة"),
      ),
      body: Column(
        children: [
          /// Ads ListView
          const AdsWidget(),

          Padding(
            padding: EdgeInsets.only(top: Sizes.dimen_10.h,
            bottom: AppUtils.mainPagesVerticalPadding.h,
            right: AppUtils.mainPagesHorizontalPadding.w,
            left: AppUtils.mainPagesHorizontalPadding.w,),
            child: ScrollableAppCard(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// title and avater
                Row(
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
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
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
                                    .caption!
                                    .copyWith(color: AppColor.accentColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    /// ImageNameRatingWidget
                    ImageNameRatingWidget(
                      name: sosEntity.creatorName,
                      imgUrl: AssetsImages.personAvatar,
                      rating: 3,
                      unRatedColor: AppColor.primaryColor.withOpacity(0.6),
                      withRow: false,
                      nameSize: Sizes.dimen_12.sp,
                      iconRateSize: Sizes.dimen_12,
                      minImageSize: Sizes.dimen_24,
                      maxImageSize: Sizes.dimen_24,
                      nameColor: AppColor.primaryDarkColor,
                      onPressed: () {
                        // RouteHelper().editProfile(context);
                      },
                    ),
                  ],
                ),

                /// Space
                SizedBox(height: Sizes.dimen_12.h),

                /// description
                Text(
                  sosEntity.description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black, height: 1.4),
                ),

                /// Space
                SizedBox(height: Sizes.dimen_12.h),


                if(widget.singleScreenArguments.withCallButton )
                AppButton(
                    text: "اتصل بالمحامى",
                    textColor: AppColor.accentColor,
                    color: AppColor.primaryDarkColor,
                    fontSize: Sizes.dimen_12.sp,
                    icon: Icon(
                      Icons.call_outlined,
                      color: AppColor.accentColor,
                      size: Sizes.dimen_16.w,
                    ),
                    onPressed: () {})
              ],
            )),
          )
        ],
      ),
    );
  }
}
