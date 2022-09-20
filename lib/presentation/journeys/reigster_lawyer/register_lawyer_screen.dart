import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/app_constants.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/presentation/journeys/reigster_lawyer/upload_id_image.dart';
import 'package:yamaiter/presentation/widgets/app_drop_down_field.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';

import '../../../common/constants/drop_down_list.dart';
import '../../../common/constants/sizes.dart';
import '../../../router/route_helper.dart';
import '../../logic/cubit/pick_images/pick_image_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_check_box.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/logo_with_title_widget.dart';
import '../../widgets/text_login_instead.dart';

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

  // pick image cubit
  late final PickImageCubit _pickImageCubit;

  @override
  void initState() {
    super.initState();
    _pickImageCubit = getItInstance<PickImageCubit>();
  }

  @override
  void dispose() {
    _pickImageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _pickImageCubit),
      ],
      child: Scaffold(
        backgroundColor: AppColor.primaryDarkColor,
        // appbar
        appBar: AppBar(),

        // body
        body: BlocListener<PickImageCubit, PickImageState>(
          listener: (context, state) {
            if (state is ErrorWhilePickingImage) {
              print("Error >> ${state.appError}");
            }

            if (state is ImagePicked) {
              print("ImagePicked >> ${state.image.path}");
            }
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppUtils.screenHorizontalPadding.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // LogoWithTitleWidget
                    const LogoWithTitleWidget(
                      title: "تسجيل محامى جديد",
                    ),

                    // Form
                    Form(
                      key: _formKey,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing:
                            20, // to apply margin in the main axis of the wrap
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
                            itemsList: subGovernoratesList,
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
                              _pickImageCubit.pickSingleImage();
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
                    LoginOrRegisterWidget(
                      isLogin: false,
                      onPressed: () =>_navigateToLoginScreen(),
                    ),

                    // bottom space
                    SizedBox(height: Sizes.dimen_30.h),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  /// return true if the form is valid
  bool _isFormValid() {
    if (_formKey.currentState != null) {
      _pickImageCubit.validate();
      return _formKey.currentState!.validate();
    }
    return false;
  }

  /// to login
  void _navigateToLoginScreen() =>
      RouteHelper().loginScreen(context,isClearStack: true);

}
