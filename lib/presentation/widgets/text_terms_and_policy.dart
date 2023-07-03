import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../common/enum/side_menu_page.dart';
import '../../domain/entities/screen_arguments/side_menu_page_args.dart';
import '../../router/route_helper.dart';
import '../themes/theme_color.dart';

class TextTermsAndPolicy extends StatelessWidget {
  const TextTermsAndPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        //text: 'By signing up, you’re agree to our ',
        children: <TextSpan>[
          /// By signing up ...
          TextSpan(
            text: "من خلال إنشاء حساب، فأنك توافق على ",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColor.white,
                  fontWeight: FontWeight.normal,
                ),
          ),

          /// terms and conditions
          TextSpan(
            text: "شروط الاستخدام ",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColor.accentColor,
                  fontWeight: FontWeight.bold,
                ),
            recognizer: TapGestureRecognizer()..onTap = () => _navigateToTermsAndConditionsScreen(context),
          ),

          /// and
          TextSpan(
            text: "و" ,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColor.white,
                  fontWeight: FontWeight.normal,
                ),
          ),

          /// privacy
          TextSpan(
            text: " سياسة الخصوصية",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColor.accentColor,
                  fontWeight: FontWeight.bold,
                ),
            recognizer: TapGestureRecognizer()..onTap = () => _navigateToPrivacyScreen(context),
          ),

          /// and
          // TextSpan(
          //   text:  " و اتفاقية المعاملات القانونية" ,
          //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
          //     color: AppColor.white,
          //     fontWeight: FontWeight.normal,
          //   ),
          // ),
        ],
      ),
    );
  }

  void _navigateToTermsAndConditionsScreen(BuildContext context) =>
      RouteHelper().sideMenuPage(
        context,
        arguments: SideMenuPageArguments(
            pageTitle: "شروط الاستخدام",
            sideMenuPage: SideMenuPage.termsAndConditions),
      );

  void _navigateToPrivacyScreen(BuildContext context) =>
      RouteHelper().sideMenuPage(
        context,
        arguments: SideMenuPageArguments(
            pageTitle: "سياسة الخصوصية", sideMenuPage: SideMenuPage.privacy),
      );
}
