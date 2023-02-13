import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../common/constants/app_utils.dart';
import '../../common/constants/assets_constants.dart';
import '../../domain/entities/data/ad_entity.dart';
import 'ads_list/ads_list_view.dart';

class AdsWidget extends StatelessWidget {
  final List<AdEntity>? adsList;

  const AdsWidget({Key? key, this.adsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: AppUtils.mainPagesHorizontalPadding.w,
        left: AppUtils.mainPagesHorizontalPadding.w,
        top: AppUtils.mainPagesVerticalPadding.h,
      ),
      child: Column(
        children: [
          AdsListViewWidget(),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: ScreenUtil.screenHeight * 0.05,
            width: double.infinity,
            color: AppColor.primaryDarkColor,
            child: Marquee(
              text:
                  'خلافاَ للإعتقاد السائد فإن لوريم إيبسوم ليس نصاَ عشوائياً. لوريم إيبسوم(Lorem Ipsum) هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر ',
              blankSpace: 100.0,
              velocity: 50.0,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: AppColor.white),
              // scrollAxis: Axis.horizontal,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // blankSpace: 20.0,
              // velocity: 100.0,
              // pauseAfterRound: Duration(seconds: 1),
              // startPadding: 10.0,
              // accelerationDuration: Duration(seconds: 1),
              // accelerationCurve: Curves.linear,
              // decelerationDuration: Duration(milliseconds: 500),
              // decelerationCurve: Curves.easeOut,
            ),
          ),
        ],
      ),
    );
  }
}
