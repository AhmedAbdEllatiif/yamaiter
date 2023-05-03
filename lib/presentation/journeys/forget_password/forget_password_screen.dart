import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/entities/screen_arguments/forget_password_arguments.dart';
import 'package:yamaiter/presentation/logic/cubit/forget_password/forget_password_cubit.dart';

import '../../../common/constants/sizes.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/logo_with_title_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final ForgetPasswordArguments arguments;

  const ForgetPasswordScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  /// controllers
  late final TextEditingController emailController;

  /// GlobalKey
  final _formKey = GlobalKey<FormState>();

  /// ForgetPasswordCubit
  late final ForgetPasswordCubit _forgetPasswordCubit;

  /// _isWrongEmail
  bool _isWrongEmail = false;

  @override
  void initState() {
    super.initState();
    _forgetPasswordCubit = getItInstance<ForgetPasswordCubit>();
    emailController = TextEditingController();
    emailController.text = widget.arguments.email;
  }

  @override
  void dispose() {
    _forgetPasswordCubit.close();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _forgetPasswordCubit,
      child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          log("State >> $state");
          _handleEmailNotExists(state is WrongEmailWhileForgetPassword);
        },
        child: Scaffold(
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
                          errorText:
                          _isWrongEmail ? "* بريد الكترونى خاطئ" : null,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Sizes.dimen_5.h,
                  ),
                  BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                    builder: (context, state) {
                      /*
                        *
                        *
                        * loading
                        *
                        *
                        * */
                      if (state is LoadingForgetPassword) {
                        return const Center(
                          child: LoadingWidget(),
                        );
                      }

                      /*
                        *
                        *
                        * error
                        *
                        *
                        * */
                      if (state is ErrorWhileSendForgetPasswordPassword) {
                        return Center(
                          child: AppErrorWidget(
                            appTypeError: state.appError.appErrorType,
                            onPressedRetry: () {
                              if (_isFormValid()) {
                                _trySendForgetPassword();
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
                      if (state is ForgetPasswordSentSuccessfully) {
                        return Center(
                          child: Text(
                            "تم ارسال طلب تغيير كلمة السر الى البريد الالكترونى",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: AppColor.accentColor,
                                    fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                      return AppButton(
                        text: "طلب تغيير كلمة المرور",
                        textColor: AppColor.primaryDarkColor,
                        color: AppColor.accentColor,
                        onPressed: () {
                          if (_isFormValid()) {
                            _trySendForgetPassword();
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

  /// try to send forget password
  void _trySendForgetPassword() {
    final email = emailController.value.text;

    _forgetPasswordCubit.tryToSendForgetPassword(email: email);
  }

  void _handleEmailNotExists(bool wrongPassword) {
    setState(() {
      _isWrongEmail = wrongPassword;
    });
  }

  /// To validate the current form
  bool _isFormValid() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }
}
