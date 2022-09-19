import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/drop_down_list.dart';
import '../../../common/constants/sizes.dart';
import '../../../router/route_helper.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_check_box.dart';
import '../../widgets/app_drop_down_field.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/logo_with_title_widget.dart';
import '../../widgets/text_login_instead.dart';

class RegisterClientScreen extends StatefulWidget {
  const RegisterClientScreen({Key? key}) : super(key: key);

  @override
  State<RegisterClientScreen> createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends State<RegisterClientScreen> {
  /// form key
  final _formKey = GlobalKey<FormState>();

  /// Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNumController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  String _governorate = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      // appbar
      appBar: AppBar(),

      // body
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppUtils.screenHorizontalPadding.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // LogoWithTitleWidget
              const LogoWithTitleWidget(
                title: "تسجيل موكل جديد",
              ),

              // Form
              Form(
                key: _formKey,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20, // to apply margin in the main axis of the wrap
                  runSpacing: 20, //
                  children: [
                    // name
                    AppTextField(
                      label: "الأسم",
                      controller: nameController,
                    ),

                    // phone num
                    AppTextField(
                      label: "رقم الهاتف المحمول",
                      controller: mobileNumController,
                      textInputType: TextInputType.number,
                      maxLength: 11,
                    ),

                    // email
                    AppTextField(
                      label: "البريد الاكترونى",
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                    ),

                    // governoratesList
                    AppDropDownField(
                      hintText: "المحافظة",
                      itemsList: governoratesList,
                      onChanged: (value) {
                        if (value != null) {
                          _governorate = value;
                        }
                      },
                    ),

                    // password
                    AppTextField(
                      label: "كلمة المرور",
                      textInputType: TextInputType.visiblePassword,
                      controller: passwordController,
                    ),

                    // re-password
                    AppTextField(
                      label: "تأكيد كلمة المرور",
                      textInputType: TextInputType.visiblePassword,
                      controller: rePasswordController,
                      rePassword: passwordController.value.text,
                    ),
                  ],
                ),
              ),

              // submit button
              Padding(
                padding: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
                child: AppButton(
                  text: "تسجيل",
                  textColor: AppColor.primaryDarkColor,
                  color: AppColor.accentColor,
                  onPressed: () {
                    print(" >> $_governorate ");
                    if (_isFormValid()) {}
                  },
                ),
              ),

              AppCheckBoxTiel(
                onChanged: (value) {},
              ),

              // already a user go to login
              LoginOrRegisterWidget(
                isLogin: false,
                onPressed: () => _navigateToLoginScreen(),
              ),

              // bottom space
              SizedBox(height: Sizes.dimen_30.h),
            ],
          ),
        ),
      ),
    );
  }

  /// return true if the form is valid
  bool _isFormValid() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }

  /// to login
  void _navigateToLoginScreen() =>
      RouteHelper().loginScreen(context,isClearStack: true);
}
