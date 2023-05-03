import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/get_user_token.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/presentation/logic/common/change_password/change_password_cubit.dart';
import 'package:yamaiter/presentation/widgets/app_error_widget.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/functions/navigate_to_login.dart';
import '../../../themes/theme_color.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/app_content_title_widget.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  /// GlobalKey
  final _formKey = GlobalKey<FormState>();

  /// controllers
  late final TextEditingController currentPasswordController;
  late final TextEditingController newPasswordController;
  late final TextEditingController confirmPasswordController;

  late final ChangePasswordCubit _changePasswordCubit;

  /// _isPasswordMatched
  bool _isPasswordMatched = true;

  /// _isWrongOldPassword
  bool _isWrongOldPassword = false;

  @override
  void initState() {
    super.initState();
    _changePasswordCubit = getItInstance<ChangePasswordCubit>();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _changePasswordCubit.close();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _changePasswordCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("تعديل كلمة المرور"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Sizes.dimen_12.h, horizontal: Sizes.dimen_12.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) {
                _handleOldPassword(state is WrongPasswordWhileChangePassword);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //==> title
                  const AppContentTitleWidget(title: "تعديل كلمة المرور"),

                  SizedBox(
                    height: Sizes.dimen_20.h,
                  ),

                  // Form
                  Form(
                    key: _formKey,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      //spacing: 20, // to apply margin in the main axis of the wrap
                      runSpacing: Sizes.dimen_6.h,
                      //
                      children: [
                        // name
                        AppTextField(
                          label: "كلمة المرور الحالية",
                          controller: currentPasswordController,
                          errorText:
                              _isWrongOldPassword ? "* كلمة مرور خاطئة" : null,
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

                        // confirm password
                        AppTextField(
                          label: "تأكيد كلمة المرور",
                          textInputType: TextInputType.visiblePassword,
                          controller: confirmPasswordController,
                          errorText: !_isPasswordMatched
                              ? "* يجب أن تكون كلمات المرور هي نفسها"
                              : null,
                          labelStyle: const TextStyle(
                            color: AppColor.primaryDarkColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///space
                  SizedBox(height: Sizes.dimen_8.h),

                  BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                    builder: (context, state) {

                      /*
                        *
                        *
                        * loading
                        *
                        *
                        * */
                      if (state is LoadingChangePassword) {
                        return const Center(
                          child: LoadingWidget(),
                        );
                      }

                      /*
                        *
                        *
                        * unAuthorized
                        *
                        *
                        * */
                      if (state is UnAuthorizedWhileChangePassword) {
                        return Center(
                          child: AppErrorWidget(
                            appTypeError: AppErrorType.unauthorizedUser,
                            onPressedRetry: () => navigateToLogin(context),
                          ),
                        );
                      }

                      /*
                        *
                        *
                        * error
                        *
                        *
                        * */
                      if (state is ErrorWhileChangingPassword) {
                        return Center(
                          child: AppErrorWidget(
                            appTypeError: state.appError.appErrorType,
                            onPressedRetry: () {
                              if (_isFormValid()) {
                                _tryToChangePassword();
                              }
                            },
                          ),
                        );
                      }

                      /*
                        *
                        *
                        * success
                        *
                        *
                        * */
                      if (state is PasswordChangeSuccessfully) {
                        return Center(
                          child: Text(
                            "تم تغيير كلمة السر بنجاح",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: AppColor.accentColor,
                                    fontWeight: FontWeight.bold),
                          ),
                        );
                      }

                      /// else
                      return AppButton(
                        text: "تغيير كلمة المرور",
                        width: double.infinity,
                        withAnimation: true,
                        textColor: AppColor.primaryDarkColor,
                        color: AppColor.accentColor,
                        onPressed: () {
                          if (_isFormValid()) {
                            _tryToChangePassword();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _tryToChangePassword() {
    final userToken = getUserToken(context);
    final oldPassword = currentPasswordController.value.text;
    final newPassword = newPasswordController.value.text;

    _changePasswordCubit.tryToChangePassword(
      userToken: userToken,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }

  void _handleOldPassword(bool wrongPassword) {
    setState(() {
      _isWrongOldPassword = wrongPassword;
    });
  }

  /// return true if form is valid
  bool _isFormValid() {
    if (_formKey.currentState != null) {
      if (newPasswordController.value.text !=
          confirmPasswordController.value.text) {
        setState(() {
          _isPasswordMatched = false;
        });
        return false;
      }

      setState(() {
        _isPasswordMatched = true;
      });
      return _formKey.currentState!.validate();
    }
    return false;
  }
}
