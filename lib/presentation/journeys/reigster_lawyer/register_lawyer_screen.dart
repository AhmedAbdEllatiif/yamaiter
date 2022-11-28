import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/data/params/register_lawyer_request_params.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';
import 'package:yamaiter/presentation/journeys/reigster_lawyer/upload_id_image.dart';
import 'package:yamaiter/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/register_lawyer/register_lawyer_cubit.dart';
import 'package:yamaiter/presentation/widgets/app_drop_down_field.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';

import '../../../common/constants/drop_down_list.dart';
import '../../../common/constants/sizes.dart';
import '../../../common/functions/common_functions.dart';
import '../../../router/route_helper.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../logic/cubit/pick_images/pick_image_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_check_box.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/logo_with_title_widget.dart';
import '../../widgets/text_login_instead.dart';

class RegisterLawyerScreen extends StatefulWidget {
  const RegisterLawyerScreen({Key? key}) : super(key: key);

  @override
  State<RegisterLawyerScreen> createState() => _RegisterLawyerScreenState();
}

class _RegisterLawyerScreenState extends State<RegisterLawyerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  String _governorate = "";
  String _subGovernorate = "";
  String _idImagePath = "";

  // pick image cubit
  late final PickImageCubit _pickImageCubit;

  // RegisterLawyerCubit
  late final RegisterLawyerCubit _registerLawyerCubit;


  @override
  void initState() {
    super.initState();
    _pickImageCubit = getItInstance<PickImageCubit>();
    _registerLawyerCubit = getItInstance<RegisterLawyerCubit>();
  }

  @override
  void dispose() {
    _pickImageCubit.close();
    _registerLawyerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _pickImageCubit),
        BlocProvider(create: (context) => _registerLawyerCubit),
      ],
      child: Scaffold(
        backgroundColor: AppColor.primaryDarkColor,
        // appbar
        appBar: AppBar(),

        // body
        body: MultiBlocListener(
          listeners: [
            //==> pick image listener
            BlocListener<PickImageCubit, PickImageState>(
              listener: (context, state) {
                if (state is ErrorWhilePickingImage) {
                  print("Error >> ${state.appError}");
                }

                if (state is ImagePicked) {
                  _idImagePath = state.image.path;
                  print("ImagePicked >> ${state.image.path}");
                }
              },
            ),

            //==>register lawyer listener
            BlocListener<RegisterLawyerCubit, RegisterLawyerState>(
              listener: (context, state) {
                if (state is ErrorWhileRegistrationLawyer) {
                  // show snackBar
                  showSnackBar(context, message: "حدث خطأ ما حاول مرة أخرى");
                  log("RegisterLawyerScreen Error >> ${state.appError}");
                }

                if (state is RegisterLawyerSuccess) {
                  // save for auto login
                  _saveForAutoLogin(context,
                      token: state.registerResponseEntity.token);
                  // save current authorized user date
                  _saveAuthorizedUserData(context,
                      userEntity: state.registerResponseEntity.userEntity);
                  // navigate to main screen
                  _navigateToMainScreen(context);
                  log("RegisterLawyerScreen RegisterLawyerSuccess");
                }
              },
            ),
          ],
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
                        //spacing: 20, // to apply margin in the main axis of the wrap
                        runSpacing: Sizes.dimen_4.h,
                        //
                        children: [
                          // name
                          AppTextField(
                            label: "الأسم",
                            controller: nameController,
                          ),

                          // phone num
                          AppTextField(
                            label: "رقم الهاتف المحمول",
                            textInputType: TextInputType.number,
                            maxLength: 11,
                            controller: phoneNumController,
                          ),

                          // email
                          AppTextField(
                            label: "البريد الاكترونى",
                            textInputType: TextInputType.emailAddress,
                            controller: emailController,
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
                            text: "إرفاق صورة كارنيه النقابة ",
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

                    /// loading or button
                    BlocBuilder<RegisterLawyerCubit, RegisterLawyerState>(
                      builder: (context, state) {
                        return switchLoadingState(state);
                      },
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

  /// to show loading or other widget according loading state
  Widget switchLoadingState(RegisterLawyerState state) {
    if (state is LoadingRegisterLawyer) {
      return const LoadingWidget();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        Padding(
          padding: EdgeInsets.only(top: Sizes.dimen_4.h),
          child: AppCheckBoxTile(
            onChanged: (value) {},
            text: "من خلال إنشاء حساب، فأنك توافق على الشروط و الأحكام سياسة الخصوصية و اتفاقية المعاملات القانونية ",
            textColor: AppColor.white,
            checkBoxColor: AppColor.accentColor,
          ),
        ),


        // submit button
        Padding(
          padding: EdgeInsets.symmetric(vertical: Sizes.dimen_4.h),
          child: AppButton(
            text: "تسجيل",
            textColor: AppColor.primaryDarkColor,
            color: AppColor.accentColor,
            onPressed: () {
              if (_isFormValid()) {
                registerNewLawyer();
              }
            },
          ),
        ),


        // already a user go to login
        LoginOrRegisterWidget(
          isLogin: false,
          onPressed: () => _navigateToLoginScreen(),
        ),
      ],
    );
  }

  /// to send register lawyer request
  void registerNewLawyer() {
    log("registerNewLawyer >> send Request");
    // init RegisterLawyerRequestParams
    final String name = nameController.value.text;
    final String email = emailController.value.text;
    final String phone = phoneNumController.value.text;
    final String governorates = _governorate;
    final String courtName = _subGovernorate;
    final String password = passwordController.value.text;
    final String idPhotoPath = _idImagePath;

    // send register request
    _registerLawyerCubit.tryToRegister(
      name: name,
      email: email,
      phone: phone,
      governorates: governorates,
      courtName: courtName,
      password: password,
      idPhotoPath: idPhotoPath,
    );
  }

  /// return true if the form is valid
  bool _isFormValid() {
    log("Password >> ${passwordController.value.text},"
        " Repassword >> ${rePasswordController.value.text}");
    if (phoneNumController.value.text.length != 11) {
      showSnackBar(context, message: "رقم هاتف غير صحيح");
      return false;
    }
    if (_formKey.currentState != null) {
      if (passwordController.value.text != rePasswordController.value.text) {
        showSnackBar(context, message: "* يجب أن تكون كلمات المرور هي نفسها");
        return false;
      }
      else if (_formKey.currentState!.validate()) {
        if (_idImagePath.isEmpty) {
          showSnackBar(context, message: "ارفاق صورة الكارنيه مطلوبة");
          return false;
        } else {
          log(
              "RegisterLawyerScreen >> trying to register but _idImagePath is empty");
        }
        return true;
      }
    }
    return false;
  }

  /// to login
  void _navigateToLoginScreen() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// to main screen
  void _navigateToMainScreen(BuildContext context) =>
      RouteHelper().main(context, isClearStack: true);

  /// to save token for auto login
  void _saveForAutoLogin(BuildContext context, {required String token}) {
    context.read<UserTokenCubit>().save(token);
  }

  /// to save current authorized user date
  void _saveAuthorizedUserData(BuildContext context,
      {required AuthorizedUserEntity userEntity}) {
    context.read<AuthorizedUserCubit>().save(userEntity);
  }
}
