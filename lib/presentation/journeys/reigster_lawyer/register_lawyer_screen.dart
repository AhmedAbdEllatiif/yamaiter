import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/app_constants.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/reigster_lawyer/upload_id_image.dart';
import 'package:yamaiter/presentation/widgets/app_drop_down_field.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';

import '../../../common/constants/drop_down_list.dart';
import '../../../common/constants/sizes.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_check_box.dart';
import '../../widgets/app_logo.dart';

class RegisterLawyerScreen extends StatefulWidget {
  const RegisterLawyerScreen({Key? key}) : super(key: key);

  @override
  State<RegisterLawyerScreen> createState() => _RegisterLawyerScreenState();
}

class _RegisterLawyerScreenState extends State<RegisterLawyerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  String _governorate = " ";
  String _subGovernorate = " ";

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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // logo
            Padding(
              padding: EdgeInsets.only(
                  bottom: Sizes.dimen_3.h, top: Sizes.dimen_5.h),
              child: AppLogo(
                size: Sizes.dimen_70.h,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: Sizes.dimen_16.h),
              child: Text(
                "تسجيل محامى جديد",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: AppColor.white, fontWeight: FontWeight.bold),
              ),
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
                  const AppTextField(label: "الأسم"),

                  // phone num
                  const AppTextField(
                    label: "رقم الهاتف المحمول",
                    textInputType: TextInputType.number,
                    maxLength: 11,
                  ),

                  // email
                  const AppTextField(
                    label: "البريد الاكترونى",
                    textInputType: TextInputType.emailAddress,
                  ),

                  // governoratesList
                  AppDropDownField(
                    hintText: "المحافظة محل العمل",
                    itemsList: governoratesList,
                    onChanged: (value) {
                      if (value != null) {
                        _governorate = value;
                      }
                    },
                  ),

                  // dropdown
                  AppDropDownField(
                    hintText: "دائرة المحكمة الكلية العليا",
                    itemsList: governoratesList,
                    onChanged: (value) {
                      if (value != null) {
                        _subGovernorate = value;
                      }
                    },
                  ),

                  // image upload
                  //const AppTextField(label: "إرفاق صورة كارنيه النقابة "),

                  UploadIdImageWidget(
                    onPressed: () {
                      print("Awesome");
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
                  print("$_governorate >> $_subGovernorate");
                  if (_isFormValid()) {}
                },
              ),
            ),

            AppCheckBoxTiel(
              onChanged: (value) {},
            ),

            // already a user go to login
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "لديك حساب بالفعل؟",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                AppButton(
                  text: "قم بتسجيل الدخول",
                  isTextButton: true,
                  textColor: AppColor.accentColor,
                  color: AppColor.accentColor,
                  onPressed: () {},
                ),
              ],
            ),

            // bottom space
            SizedBox(height: Sizes.dimen_16.h),
          ]),
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

  bool _isPasswordNotMatched() {
    final password = passwordController.value.text;
    final rePassword = rePasswordController.value.text;
    return password != rePassword;
  }
}
