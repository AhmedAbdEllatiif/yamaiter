import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/presentation/logic/cubit/user_token/user_token_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';
import 'package:yamaiter/presentation/widgets/logo_with_title_widget.dart';
import 'package:yamaiter/presentation/widgets/text_login_instead.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/functions/common_functions.dart';
import '../../../common/screen_utils/screen_util.dart';
import '../../../domain/entities/data/authorized_user_entity.dart';
import '../../../router/route_helper.dart';
import '../../logic/cubit/authorized_user/authorized_user_cubit.dart';
import '../../logic/cubit/login/login_cubit.dart';
import '../../widgets/app_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// GlobalKey
  final _formKey = GlobalKey<FormState>();

  /// login cubit
  late final LoginCubit _loginCubit;

  @override
  void initState() {
    super.initState();
    _initScreenUtil();
    _loginCubit = getItInstance<LoginCubit>();
  }

  @override
  void dispose() {
    _loginCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _loginCubit,
      child: Scaffold(
        backgroundColor: AppColor.primaryDarkColor,

        /// appBar
        appBar: AppBar(),

        /// body
        body: BlocListener<LoginCubit, LoginState>(
          listener: (_, state) {
            // error
            if (state is ErrorWhileLogin) {
              // show snackBar
              showSnackBar(context, message: "حدث خطأ ما حاول مرة أخرى");
            }
            // success
            if (state is LoginSuccess) {
              // save for auto login
              _saveForAutoLogin(context,
                  token: state.loginResponseEntity.token);
              // save current authorized user date
              _saveAuthorizedUserData(context,
                  userEntity: state.loginResponseEntity.userEntity);
              // navigate to main screen
              _navigateToMainScreen(context);
            }
          },
          child: Padding(
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
                    child: BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            AppTextField(
                              label: "البريد الإلكتروني",
                              errorText: _getEmailErrorMessage(state),
                              textInputType: TextInputType.emailAddress,
                              controller: emailController,
                            ),
                            SizedBox(
                              height: Sizes.dimen_5.h,
                            ),
                            AppTextField(
                              label: "كلمة مرور",
                              errorText: _getPasswordErrorMessage(state),
                              textInputType: TextInputType.visiblePassword,
                              controller: passwordController,
                            ),

                            //==> space between form and login button
                            SizedBox(
                              height: Sizes.dimen_5.h,
                            ),

                            switchLoadingState(state)
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// to show loading or other widget according loading state
  Widget switchLoadingState(LoginState state) {
    if (state is LoadingLogin) {
      return const LoadingWidget();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //==> login button
        AppButton(
          text: "تسجيل دخول",
          textColor: AppColor.primaryDarkColor,
          color: AppColor.accentColor,
          onPressed: () {
            if (_isFormValid()) {
              _sendLoginRequest();
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
    );
  }

  /// return an error message according error from [state]
  String _getPasswordErrorMessage(LoginState state) {
    if (state is WrongPassword) {
      return "* إدخال كلمة مرور خاطئة";
    }

    return "";
  }

  /// return an error message according error from [state]
  String _getEmailErrorMessage(LoginState state) {
    if (state is WrongEmail) {
      return "* إدخال بريد إلكتروني خاطئ";
    }
    return "";
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

  /// to validate the current form
  bool _isFormValid() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }

  /// to send login request
  void _sendLoginRequest() {
    final email = emailController.value.text;
    final password = passwordController.value.text;
    _loginCubit.tryToLogin(email: email, password: password);
  }

  /// to save token for auto login
  void _saveForAutoLogin(BuildContext context, {required String token}) {
    context.read<UserTokenCubit>().save(token);
  }

  /// to save current authorized user date
  void _saveAuthorizedUserData(BuildContext context,
      {required AuthorizedUserEntity userEntity}) {
    context.read<AuthorizedUserCubit>().save(userEntity);
  }

  /// to ensure init ScreenUtil
  void _initScreenUtil() {
    if (ScreenUtil.screenHeight == 0) {
      final h = MediaQuery.of(context).size.height;
      final w = MediaQuery.of(context).size.width;
      ScreenUtil.init(height: h, width: w);
    }
  }
}
