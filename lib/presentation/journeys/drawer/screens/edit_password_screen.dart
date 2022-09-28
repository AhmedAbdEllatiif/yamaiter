import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/functions/common_functions.dart';
import '../../../themes/theme_color.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/static_pages_title_widget.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  /// controllers
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  /// GlobalKey
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل كلمة المرور"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Sizes.dimen_12.h, horizontal: Sizes.dimen_12.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //==> title
              const StaticPageTitleWidget(title: "تعديل كلمة المرور"),

              SizedBox(
                height: Sizes.dimen_20.h,
              ),

              // Form
              Form(
                key: _formKey,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  //spacing: 20, // to apply margin in the main axis of the wrap
                  runSpacing: Sizes.dimen_6.h, //
                  children: [
                    // name
                    AppTextField(
                      label: "كلمة المرور الحالية",
                      controller: currentPasswordController,
                      labelStyle: const TextStyle(
                        color: AppColor.primaryDarkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // phone num
                    AppTextField(
                      label: "كلمة المرور الجديدة",
                      textInputType: TextInputType.visiblePassword,
                      controller: newPasswordController,
                      labelStyle: const TextStyle(
                        color: AppColor.primaryDarkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // email
                    AppTextField(
                      label: "تأكيد كلمة المرور",
                      textInputType: TextInputType.visiblePassword,
                      controller: confirmPasswordController,
                      labelStyle: const TextStyle(
                        color: AppColor.primaryDarkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // submit button
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
                  child: AppButton(
                    text: "تغيير كلمة المرور",
                    withAnimation: true,
                    textColor: AppColor.primaryDarkColor,
                    color: AppColor.accentColor,
                    onPressed: () {
                      if (_isFormValid()) {}
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isFormValid() {
    if (_formKey.currentState != null) {
      if (newPasswordController.value.text !=
          confirmPasswordController.value.text) {
        showSnackBar(
          context,
          message: "* يجب أن تكون كلمات المرور هي نفسها",
          backgroundColor: AppColor.primaryDarkColor,
          textColor: AppColor.white,
        );
        return false;
      }
      return _formKey.currentState!.validate();
    }
    return false;
  }
}
