import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../../common/constants/drop_down_list.dart';
import '../../../common/constants/sizes.dart';
import '../../../common/enum/app_error_type.dart';
import '../../../common/functions/common_functions.dart';
import '../../../di/git_it_instance.dart';
import '../../../router/route_helper.dart';
import '../../logic/cubit/create_ad/create_ad_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_content_title_widget.dart';
import '../../widgets/app_drop_down_field.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/scrollable_app_card.dart';

class CreateAdForm extends StatefulWidget {
  final bool withWhiteCard;
  final Function() onSuccess;
  final CreateAdCubit? createAdCubit;

  const CreateAdForm(
      {Key? key,
      required this.withWhiteCard,
      required this.onSuccess,
      this.createAdCubit})
      : super(key: key);

  @override
  State<CreateAdForm> createState() => _CreateAdFormState();
}

class _CreateAdFormState extends State<CreateAdForm> {
  String _adPage = "";
  late final CreateAdCubit _createAdCubit;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _createAdCubit = widget.createAdCubit ?? getItInstance<CreateAdCubit>();
  }

  @override
  void dispose() {
    if (widget.createAdCubit == null) {
      _createAdCubit.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _createAdCubit,
      child: BlocListener<CreateAdCubit, CreateAdState>(
        bloc: _createAdCubit,
        listener: (_, state) {
          /// show snackBar on badInternetConnection
          if (state is ErrorWhileCreatingAd) {
            showSnackBar(context,
                backgroundColor: AppColor.accentColor,
                textColor: AppColor.primaryDarkColor,
                isFloating: false,
                message: "تحقق من اتصال الإنترنت");
          }

          /// success
          if (state is AdCreatedSuccessfully) {
            _navigateToMyAds();
          }
        },
        child: widget.withWhiteCard
            ? ScrollableAppCard(
                child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// title
                    const AppContentTitleWidget(title: "طلب اعلان دعائى"),

                    /// form
                    Padding(
                      padding: EdgeInsets.only(top: Sizes.dimen_5.h),
                      child: _form(),
                    ),
                  ],
                ),
              ))
            : Container(
                margin: EdgeInsets.only(top: Sizes.dimen_30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// title
                    AppContentTitleWidget(
                      title: widget.withWhiteCard
                          ? "طلب اعلان دعائى"
                          : "طلب اعلان",
                      textStyle: widget.withWhiteCard
                          ? null
                          : Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: AppColor.white,
                              fontWeight: FontWeight.bold),
                      textColor: widget.withWhiteCard
                          ? AppColor.primaryDarkColor
                          : AppColor.white,
                    ),

                    /// form
                    Padding(
                      padding: EdgeInsets.only(
                          top: widget.withWhiteCard
                              ? Sizes.dimen_5.h
                              : Sizes.dimen_14.h),
                      child: _form(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _form() {
    return Column(
      children: [
        /// ad pages
        Form(
          key: _formKey,
          child: AppDropDownField(
            hintText: "صفحة الاعلان",
            itemsList: adPages,
            //height: Sizes.dimen_22.h,
            margin: EdgeInsets.only(bottom: Sizes.dimen_4.h),
            onChanged: (value) {
              if (value != null) {
                _adPage = value;
              }
            },
          ),
        ),

        /// space
        SizedBox(height: Sizes.dimen_5.h),

        /// button
        SizedBox(
          width: double.infinity,
          child: BlocBuilder<CreateAdCubit, CreateAdState>(
            bloc: _createAdCubit,
            builder: (context, state) {
              if (state is LoadingCreateAd) {
                return const Center(
                  child: LoadingWidget(),
                );
              }

              /// UnAuthorizedCreateSos
              if (state is UnAuthorizedCreateAd) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.unauthorizedUser,
                    buttonText: "تسجيل الدخول",
                    onPressedRetry: () {
                      _navigateToLogin();
                    },
                  ),
                );
              }

              /// NotActivatedUserToCreateSos
              if (state is NotActivatedUserToCreateAd) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.notActivatedUser,
                    buttonText: "تواصل معنا",
                    message:
                        "نأسف لذلك، لم يتم تفعيل حسابك سوف تصلك رسالة بريدية عند التفعيل",
                    onPressedRetry: () {
                      _navigateToContactUs();
                    },
                  ),
                );
              }

              return AppButton(
                text: "طلب الاعلان",
                color: AppColor.accentColor,
                textColor: AppColor.primaryDarkColor,
                onPressed: () {
                  if (_isFormValid()) {
                    _sendCreateAdRequest();
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  /// to send create ad request
  void _sendCreateAdRequest() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // init place
    final place = _adPage;

    // send a request
    _createAdCubit.createAd(place: place, token: userToken);
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to my ads
  void _navigateToMyAds() {
    widget.onSuccess();
  }

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);

  /// to validate the current form
  bool _isFormValid() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }
}
