import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/assets_constants.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/app_logo.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../common/constants/sizes.dart';

class ChooseUserTypeScreen extends StatelessWidget {
  const ChooseUserTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_60.w),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: Sizes.dimen_10.h, top: Sizes.dimen_60.h),
                child: AppLogo(
                  size: Sizes.dimen_100.h,
                ),
              ),
              AppButton(
                text: "انشاء حساب محامى",
                onPressed: () => _navigateToRegisterLawyer(context),
              ),
              SizedBox(
                height: Sizes.dimen_5.h,
              ),
              AppButton(
                  text: "انشاء حساب زائر",
                  onPressed: () => _navigateToRegisterClient(context)),
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
      ),
    );
  }

  void _navigateToRegisterLawyer(BuildContext context) =>
      RouteHelper().registerLawyer(context);

  void _navigateToRegisterClient(BuildContext context) =>
      RouteHelper().registerClient(context);
}
