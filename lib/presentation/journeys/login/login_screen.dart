import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/logic/cubit/auto_login/auto_login_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';
import 'package:yamaiter/presentation/widgets/logo_with_title_widget.dart';
import 'package:yamaiter/presentation/widgets/text_login_instead.dart';

import '../../../common/constants/sizes.dart';
import '../../../router/route_helper.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_logo.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  /// controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                title: "تسجيل الدخول",
              ),

              // form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppTextField(
                      label: "البريد الإلكتروني",
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    SizedBox(
                      height: Sizes.dimen_5.h,
                    ),
                    AppTextField(
                      label: "كلمة مرور",
                      textInputType: TextInputType.visiblePassword,
                      controller: passwordController,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Sizes.dimen_5.h,
              ),

              // login button
              AppButton(
                text: "تسجيل دخول",
                textColor: AppColor.primaryDarkColor,
                color: AppColor.accentColor,
                onPressed: () {
                  if (_isFormValid()) {
                    _saveForAutoLogin(context,token: "This is new token");
                    _navigateToMainScreen(context);
                  }
                },
              ),
              SizedBox(
                height: Sizes.dimen_5.h,
              ),

              // LoginOrRegisterWidget
              LoginOrRegisterWidget(
                isLogin: true,
                onPressed: () => _navigateToChooserUserTypeScreen(context),
                onForgetPasswordPressed: () =>
                    _navigateToForgetPasswordScreen(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// to main screen
  void _navigateToMainScreen(BuildContext context) =>
      RouteHelper().main(context, isClearStack: true);

  /// to forget password screen
  void _navigateToForgetPasswordScreen(BuildContext context) =>
      RouteHelper().forgetPassword(context);

  /// to choose user type screen
  void _navigateToChooserUserTypeScreen(BuildContext context) =>
      RouteHelper().chooseUserType(context);

  /// To validate the current form
  bool _isFormValid() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }

  void _saveForAutoLogin(BuildContext context, {required String token}) {
    context.read<AutoLoginCubit>().save(token);
  }
}
