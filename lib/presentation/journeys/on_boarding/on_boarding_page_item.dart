import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:yamaiter/common/constants/assets_constants.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/sizes.dart';
import '../../../common/screen_utils/screen_util.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_logo.dart';

class OnBoardingPageItem extends StatelessWidget {

  final String imgPath;
  const OnBoardingPageItem({Key? key, required this.imgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryDarkColor,
      padding: EdgeInsets.symmetric(
          horizontal: AppUtils.screenHorizontalPadding,
          vertical: Sizes.dimen_20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // App Logo
          SizedBox(
            height: ScreenUtil.screenHeight * 0.20,
            child: const AppLogo(),
          ),

          // Image
          /*CircleAvatar(
            backgroundColor: AppColor.deepOrange,
            radius: ResponsiveValue(context,
                defaultValue: Sizes.dimen_40.h,
                valueWhen: [
                  Condition.largerThan(name: TABLET, value: Sizes.dimen_50.h),
                  Condition.equals(name: TABLET, value: Sizes.dimen_50.h),
                  Condition.equals(name: MOBILE, value: Sizes.dimen_35.h),
                  Condition.smallerThan(name: MOBILE, value: Sizes.dimen_35.h),
                ]).value,
          ),
*/
          SizedBox(
            height: ResponsiveValue(context,
                defaultValue: Sizes.dimen_40.h,
                valueWhen: [
                  Condition.largerThan(name: TABLET, value: Sizes.dimen_150.h),
                  Condition.equals(name: TABLET, value: Sizes.dimen_150.h),
                  Condition.equals(name: MOBILE, value: Sizes.dimen_110.h),
                  Condition.smallerThan(name: MOBILE, value: Sizes.dimen_80.h),
                ]).value,
            child: Image.asset(
              imgPath,
            ),
          ),

          // Title
          Container(
            //padding: EdgeInsets.only(top: Sizes.dimen_2.h),
            constraints:
                BoxConstraints(maxHeight: ScreenUtil.screenWidth * 0.50),
            child: Text(
              " عن تطبيق يامترعن تطبيق يامتر",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColor.white, fontWeight: FontWeight.w600),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(vertical: Sizes.dimen_3.h),
            child: Text(
              "كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت مطبعة مجهولة برص مجموعة من الأحرف بشكل عشوائي أخذتها من نص، لتكوّن كتيّب بمثابة دليل أو مرجع شكلي لهذه الأحرف. خمسة قرون من الزمن لم تقضي على هذا النص.",
              textAlign: TextAlign.center,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: AppColor.white),
            ),
          ),
        ],
      ),
    );
  }
}
