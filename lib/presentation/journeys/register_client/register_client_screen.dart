import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/common_functions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/presentation/logic/cubit/register_client/register_client_cubit.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/drop_down_list.dart';
import '../../../common/constants/sizes.dart';
import '../../../domain/entities/data/authorized_user_entity.dart';
import '../../../router/route_helper.dart';
import '../../logic/cubit/authorized_user/authorized_user_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
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

  late final RegisterClientCubit _registerClientCubit;

  /// Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNumController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  String _governorate = "";
  bool isTermsAccepted = false;
  bool acceptTermsHasError = false;

  @override
  void initState() {
    super.initState();
    _registerClientCubit = getItInstance<RegisterClientCubit>();
  }

  @override
  void dispose() {
    _registerClientCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _registerClientCubit,
      child: Scaffold(
        backgroundColor: AppColor.primaryDarkColor,
        // appbar
        appBar: AppBar(),

        // body
        body: BlocListener<RegisterClientCubit, RegisterClientState>(
          listener: (context, state) {
            // success
            if (state is RegisterClientSuccess) {
              // save for auto login
              _saveForAutoLogin(context,
                  token: state.registerResponseEntity.token);
              // save current authorized user date
              _saveAuthorizedUserData(context,
                  userEntity: state.registerResponseEntity.userEntity);
              // navigate to main screen
              _navigateToMainScreen();
            }

            // email already exists
            if (state is ClientEmailAlreadyExists) {
              showSnackBar(context, message: "البريد الاكترونى مستخدم من قبل");
            }

            // phone already exists
            if (state is ClientNumberAlreadyExists) {
              showSnackBar(context, message: "رقم الهاتف مستخدم من قبل");
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
                    title: "تسجيل موكل جديد",
                  ),

                  // Form
                  Form(
                    key: _formKey,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      // to apply margin in the main axis of the wrap
                      runSpacing: 20,
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

                  BlocBuilder<RegisterClientCubit, RegisterClientState>(
                    builder: (context, state) {
                      //==> loading
                      if (state is LoadingRegisterClient) {
                        return const LoadingWidget();
                      }

                      //==> else
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // submit button
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
                            child: AppButton(
                              text: "تسجيل",
                              textColor: AppColor.primaryDarkColor,
                              color: AppColor.accentColor,
                              onPressed: () {
                                if (_validate()) {
                                  _tryToRegisterClient();
                                }
                              },
                            ),
                          ),

                          AppCheckBoxTile(
                            onChanged: (value) {
                              if (value != null) {
                                isTermsAccepted = value;
                                _showOrHideAcceptTermsError(false);
                              }
                            },
                            text:
                                "من خلال إنشاء حساب، فأنك توافق على الشروط و الأحكام سياسة الخصوصية و اتفاقية المعاملات القانونية ",
                            hasError: acceptTermsHasError,
                            textColor: AppColor.white,
                            checkBoxColor: AppColor.accentColor,
                          ),

                          // already a user go to login
                          LoginOrRegisterWidget(
                            isLogin: false,
                            onPressed: () => _navigateToLoginScreen(),
                          ),

                          // bottom space
                          SizedBox(height: Sizes.dimen_30.h),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// return true if the form is valid
  bool _validate() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        if (isTermsAccepted) {
          return true;
        }
        _showOrHideAcceptTermsError(true);
        return false;
      }
      return false;
    }
    return false;
  }

  /// to show or hide you have to accept terms
  void _showOrHideAcceptTermsError(bool showError) {
    if (showError) {
      setState(() {
        acceptTermsHasError = true;
      });
    } else {
      setState(() {
        acceptTermsHasError = false;
      });
    }
  }

  /// try to register a new client
  void _tryToRegisterClient() {
    final email = emailController.value.text;
    final name = nameController.value.text;
    final phoneNumber = mobileNumController.value.text;
    final password = passwordController.value.text;
    final termsAcceptance = isTermsAccepted;

    _registerClientCubit.tryToRegister(
      name: name,
      email: email,
      phone: phoneNumber,
      governorates: _governorate,
      password: password,
      isTermsAccepted: termsAcceptance,
    );
  }

  /// to login
  void _navigateToLoginScreen() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// to mainScreen
  void _navigateToMainScreen() =>
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
