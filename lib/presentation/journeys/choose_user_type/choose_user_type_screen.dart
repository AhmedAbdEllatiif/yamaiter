import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/widget_extension.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/app_logo.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/enum/animation_type.dart';

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
              ).animate(
            slideDuration: const Duration(milliseconds: 300),
            fadeDuration: const Duration(milliseconds: 300),
            map: {
              AnimationType.slide: {
                SlideOffset.begin: const Offset(0.0, -0.5),
                SlideOffset.end: const Offset(0.0, 0.0),
              },
              AnimationType.fade: {
                FadeOpacity.begin: 0.5,
                FadeOpacity.end: 1.0,
              },
            }),



              AppButton(
                text: "انشاء حساب محامى",
                withAnimation: true,
                onPressed: () => _navigateToRegisterLawyer(context),
              ),
              SizedBox(
                height: Sizes.dimen_5.h,
              ),
              AppButton(
                  text: "انشاء حساب زائر",
                  withAnimation: true,
                  onPressed: () => _navigateToRegisterClient(context)),
              SizedBox(
                height: Sizes.dimen_5.h,
              ),
              AppButton(
                text: "تسجيل دخول",
                withAnimation: true,
                textColor: AppColor.primaryDarkColor,
                color: AppColor.accentColor,
                onPressed: ()=> _navigateToLoginScreen(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// to register lawyer
  void _navigateToRegisterLawyer(BuildContext context) =>
      RouteHelper().registerLawyer(context);

  /// to register client
  void _navigateToRegisterClient(BuildContext context) =>
      RouteHelper().registerClient(context);
  
  /// to login
  void _navigateToLoginScreen(BuildContext context) =>
      RouteHelper().loginScreen(context,isClearStack: false);
}
