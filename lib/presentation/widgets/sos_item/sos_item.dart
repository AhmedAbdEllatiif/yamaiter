import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_sos_screen_args.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/sos_item/sos_menu_item.dart';

import '../../../common/constants/assets_constants.dart';
import '../../../common/constants/sizes.dart';
import '../../../router/route_helper.dart';
import '../image_name_rating_widget.dart';

class SosItem extends StatefulWidget {
  final SosEntity sosEntity;
  final bool withCallLawyer;

  const SosItem(
      {Key? key, required this.sosEntity, required this.withCallLawyer})
      : super(key: key);

  @override
  State<SosItem> createState() => _SosItemState();
}

class _SosItemState extends State<SosItem> {
  bool _isMenuOpened = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _navigateToSingleSosScreen(),
        borderRadius: BorderRadius.circular(AppUtils.cornerRadius),
        child: Padding(
          padding: EdgeInsets.only(
              left: Sizes.dimen_8.w,
              right: Sizes.dimen_8.w,
              bottom: Sizes.dimen_8.h),
          child: Stack(children: [
            Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// ImageNameRatingWidget
                  ImageNameRatingWidget(
                    name: widget.sosEntity.creatorName,
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

                  /// data
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: Sizes.dimen_4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// title
                          Text(
                            widget.sosEntity.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      height: 3,
                                    ),
                          ),

                          /// description
                          Text(
                            widget.sosEntity.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.normal,
                                      height: 1.3,
                                    ),
                          ),

                          /// date
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                color: AppColor.accentColor,
                                size: Sizes.dimen_12.w,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 3),
                                child: Text(
                                  widget.sosEntity.createdAtString,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: AppColor.accentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// button
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _navigateToSingleSosScreen();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColor.accentColor,
                                borderRadius: BorderRadius.circular(
                                    AppUtils.cornerRadius)),
                            padding: EdgeInsets.symmetric(
                                horizontal: Sizes.dimen_10.w),
                            child: Text(
                              "اقرأ المزيد",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: AppColor.primaryDarkColor),
                            ),
                          ),
                        ),
                      ),


                      if(widget.withCallLawyer)
                      Padding(
                        padding:  EdgeInsets.only(top: Sizes.dimen_3.h,),
                        child: GestureDetector(
                          onTap: () {
                            //_navigateToSingleSosScreen();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColor.primaryDarkColor,
                                  borderRadius: BorderRadius.circular(
                                      AppUtils.cornerRadius)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.dimen_10.w),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.call_outlined,
                                    color: AppColor.accentColor,
                                    size: Sizes.dimen_16.w,
                                  ),
                                  Text(
                                    "اتصل بالمحامى",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: AppColor.accentColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if(!widget.withCallLawyer)
            Positioned(
              top: 0.0,
              left: Sizes.dimen_10.w,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isMenuOpened = !_isMenuOpened;
                  });
                },
                child: Text(
                  "...",
                  style: TextStyle(
                      fontSize: Sizes.dimen_20.sp,
                      color: AppColor.primaryDarkColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            if(!widget.withCallLawyer)
            if (_isMenuOpened)
              Positioned(
                top: Sizes.dimen_30,
                left: Sizes.dimen_10.w,
                child: Container(
                  padding: EdgeInsets.all(Sizes.dimen_5.w),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      border: Border.all(color: AppColor.primaryDarkColor)),
                  child: Column(
                    children: [
                      SosMenuItem(
                        text: "Option1",
                        onPressed: () {},
                      ),
                      SosMenuItem(
                        text: "Option2",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }

  /// To navigate to single screen sos
  void _navigateToSingleSosScreen() => RouteHelper().singleSosScreen(context,
      arguments: SingleScreenArguments(
        sosEntity: widget.sosEntity,
        withCallButton: widget.withCallLawyer,
      ));
}
