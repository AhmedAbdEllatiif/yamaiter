import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/constants/assets_constants.dart';
import 'package:yamaiter/common/constants/drop_down_list.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/common_functions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/domain/entities/data/ad_entity.dart';
import 'package:yamaiter/presentation/logic/cubit/create_sos/create_sos_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/app_content_title_widget.dart';
import 'package:yamaiter/presentation/widgets/app_drop_down_field.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';
import 'package:yamaiter/presentation/widgets/scrollable_app_card.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/enum/app_error_type.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../widgets/ads_list/ads_list_view.dart';
import '../../widgets/ads_list/ads_list_view.dart';
import '../../widgets/app_error_widget.dart';

class CreateSosScreen extends StatefulWidget {
  const CreateSosScreen({Key? key}) : super(key: key);

  @override
  State<CreateSosScreen> createState() => _CreateSosScreenState();
}

class _CreateSosScreenState extends State<CreateSosScreen> {
  late final CreateSosCubit _createSosCubit;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  String type = "";
  String governorate = "";

  @override
  void initState() {
    super.initState();
    _createSosCubit = getItInstance<CreateSosCubit>();
  }

  @override
  void dispose() {
    _createSosCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _createSosCubit,
      child: BlocListener<CreateSosCubit, CreateSosState>(
        listener: (context, state) {
          //==> show snack bar with check internet connection
          if (state is ErrorWhileCreatingSos) {
            showSnackBar(context, message: "تحقق من اتصال الإنترنت");
          }

          //==> on success navigate to my sos screen
          if(state is SosCreatedSuccessfully){
            _navigateToMySosScreen();
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppUtils.mainPagesHorizontalPadding.w,
                vertical: AppUtils.mainPagesVerticalPadding.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Ads ListView
                const AdsListViewWidget(
                  adsList: [
                    AdEntity(id: 0, url: AssetsImages.adSample),
                    AdEntity(id: 1, url: AssetsImages.adSample),
                    AdEntity(id: 1, url: AssetsImages.adSample),
                  ],
                ),

                ///  card
                Padding(
                  padding: EdgeInsets.only(top: Sizes.dimen_10.h),
                  child: BlocBuilder<CreateSosCubit, CreateSosState>(
                    builder: (context, state) {


                      /// UnAuthorizedCreateSos
                      if (state is UnAuthorizedCreateSos) {
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
                      if (state is NotActivatedUserToCreateSos) {
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

                      return ScrollableAppCard(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// title
                          const AppContentTitleWidget(
                              title: "نشر استغاثة طارئة"),

                          //==> space
                          SizedBox(height: Sizes.dimen_8.h),

                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                AppDropDownField(
                                    hintText: "حدد نوع حالة الطوارئ",
                                    itemsList: sosTypeList,
                                    onChanged: (value) {
                                      if (value != null) {
                                        type = value;
                                      }
                                    }),

                                //==> space
                                SizedBox(height: Sizes.dimen_5.h),

                                AppDropDownField(
                                    hintText: "انشر فى نطاق",
                                    itemsList: governoratesListWithSelectAll,
                                    isLastItemHighlighted: true,
                                    onChanged: (value) {
                                      if (value != null) {
                                        governorate = value;
                                      }
                                    }),

                                //==> space
                                SizedBox(height: Sizes.dimen_5.h),

                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Sizes.dimen_8.h,
                                      horizontal: Sizes.dimen_5.w),
                                  constraints: BoxConstraints(
                                      minHeight: ScreenUtil.screenHeight * 0.15,
                                      maxHeight:
                                          ScreenUtil.screenHeight * 0.30),
                                  decoration: BoxDecoration(
                                      color: AppColor.primaryColor,
                                      borderRadius: BorderRadius.circular(
                                          AppUtils.cornerRadius)),
                                  child: AppTextField(
                                    controller: descriptionController,
                                    label:
                                        "اكتب تفاصيل ما تتعرض له للنشر على زملائك",
                                    maxLines: 20,
                                    validateOnSubmit: false,
                                    withFocusedBorder: false,
                                    textInputType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //==> space
                          SizedBox(height: Sizes.dimen_5.h),

                          _switchLoadingAndButton(state),

                          //==> space
                          SizedBox(height: Sizes.dimen_20.h),
                        ],
                      ));
                    },
                  ),
                ),

                //==> space under the card
                SizedBox(height: Sizes.dimen_20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// switch between loading or button
  Widget _switchLoadingAndButton(CreateSosState state) {
    if (state is LoadingCreateSos) {
      return const Center(
        child: LoadingWidget(),
      );
    }

    return AppButton(
      text: "انشر استغاثتى على الزملاء",
      color: AppColor.accentColor,
      textColor: AppColor.primaryDarkColor,
      withAnimation: true,
      width: double.infinity,
      onPressed: () {
        if (_isFormValid()) {
          _sendSos();
        }
      },
    );
  }

  /// to validate the current form
  bool _isFormValid() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }

  /// send sos
  void _sendSos() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // init description
    final description = descriptionController.value.text;

    // send create sos request
    _createSosCubit.sendSos(
      type: type,
      governorate: governorate,
      description: description.isNotEmpty ? description : "لا يوجد",
      token: userToken,
    );
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() =>
      RouteHelper().contactUsScreen(context);

  /// navigate to my sos
  void _navigateToMySosScreen()=>
      RouteHelper().mySosScreen(context);
}
