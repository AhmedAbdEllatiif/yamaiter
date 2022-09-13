import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/assets_constants.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';

import '../../../common/constants/sizes.dart';

class ChooseUserTypeScreen extends StatelessWidget {
  const ChooseUserTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_60.w),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Padding(
              padding:  EdgeInsets.only(bottom: Sizes.dimen_10.h,top:  Sizes.dimen_60.h),
              child: Image.asset(AssetsImages.personAvatar,height: Sizes.dimen_100.h,width: Sizes.dimen_100.w,),
            ),

            AppButton(
              text: "انشاء حساب محامى",
              onPressed: () {},
            ),
            SizedBox(
              height: Sizes.dimen_5.h,
            ),
            AppButton(text: "انشاء حساب زائر", onPressed: () {}),
            SizedBox(
              height: Sizes.dimen_5.h,
            ),
            AppButton(
              text: "تسجيل دخول",
              textColor: AppColor.primaryDarkColor,
              color: AppColor.accentColor,
              onPressed: () {},

            ),
          ],
        ),
      ),
    );
  }
}
