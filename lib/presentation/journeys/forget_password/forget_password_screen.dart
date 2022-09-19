import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../../common/constants/sizes.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/logo_with_title_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  /// controllers
  final TextEditingController emailController = TextEditingController();

  /// GlobalKey
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_40.w),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // LogoWithTitleWidget
              const LogoWithTitleWidget(
                title: "إعادة إنشاء كلمة المرور",
              ),

              Padding(
                padding: EdgeInsets.only(bottom: Sizes.dimen_16.h),
                child: Text(
                  "أدخل بريدك الإلكتروني واطلب تغيير كلمة المرور الخاصة بك",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColor.white, fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppTextField(
                      label: "البريد الإلكتروني",
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Sizes.dimen_5.h,
              ),
              AppButton(
                text: "طلب تغيير كلمة المرور",
                textColor: AppColor.primaryDarkColor,
                color: AppColor.accentColor,
                onPressed: () {
                  if (_isFormValid()) {
                    //_navigateToMainScreen(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// To validate the current form
  bool _isFormValid() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }
}
