import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/entities/data/pay_entity.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../common/constants/app_utils.dart';
import '../../../../common/constants/sizes.dart';
import '../../../../common/enum/app_error_type.dart';
import '../../../../common/functions/common_functions.dart';
import '../../logic/client_cubit/create_consultation/create_consultation_cubit.dart';
import '../../logic/cubit/pick_images/pick_image_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_content_title_widget.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/scrollable_app_card.dart';
import '../../widgets/text_field_large_container.dart';
import '../reigster_lawyer/upload_id_image.dart';

class ConsultationForm extends StatefulWidget {
  final bool withWithCard;
  final Function(PayEntity) onSuccess;
  final CreateConsultationCubit? createConsultationCubit;
  final double consultFees;

  const ConsultationForm({
    Key? key,
    required this.consultFees,
    required this.onSuccess,
    this.withWithCard = true,
    this.createConsultationCubit,
  }) : super(key: key);

  @override
  State<ConsultationForm> createState() => _ConsultationFormState();
}

class _ConsultationFormState extends State<ConsultationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  /// imagerPicker cubit
  late final PickImageCubit _pickImageCubit;

  /// CreateConsultationCubit
  late final CreateConsultationCubit _createConsultationCubit;

  final List<String> _imagesPicked = [];

  @override
  void initState() {
    super.initState();
    _pickImageCubit = getItInstance<PickImageCubit>();
    _createConsultationCubit = widget.createConsultationCubit ??
        getItInstance<CreateConsultationCubit>();
  }

  @override
  void dispose() {
    _pickImageCubit.close();

    /// to close if the cubit init by the form state
    if (widget.createConsultationCubit == null) {
      _createConsultationCubit.close();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _pickImageCubit),
        BlocProvider(create: (context) => _createConsultationCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          /// PickImageCubit
          BlocListener<PickImageCubit, PickImageState>(
            listener: (context, state) {
              if (state is MultiImagesPicked) {
                if (state.multiImages != null) {
                  _imagesPicked.addAll(state.multiImages!);
                }
              }
            },
          ),

          /// CreateConsultationCubit
          BlocListener<CreateConsultationCubit, CreateConsultationState>(
            bloc: _createConsultationCubit,
            listener: (context, state) {
              //==> show snack bar with check internet connection
              if (state is ErrorWhileCreatingConsultation) {
                showSnackBar(context,
                    backgroundColor: AppColor.accentColor,
                    textColor: AppColor.primaryDarkColor,
                    isFloating: false,
                    message: "تحقق من اتصال الإنترنت");
              }

              //==> on success navigate to my sos screen
              if (state is ConsultationCreatedSuccessfully) {
                _onSuccess(state.payEntity);
              }
            },
          )
        ],
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppUtils.mainPagesHorizontalPadding.w,
              vertical: AppUtils.mainPagesVerticalPadding.h),
          child: Padding(
            padding: EdgeInsets.only(top: Sizes.dimen_10.h),
            child:
                BlocBuilder<CreateConsultationCubit, CreateConsultationState>(
                    bloc: _createConsultationCubit,
                    builder: (context, state) {
                      /// UnAuthorizedCreateSos
                      if (state is UnAuthorizedCreateConsultation) {
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
                      if (state is NotActivatedUserToCreateConsultation) {
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

                      return widget.withWithCard
                          ? ScrollableAppCard(
                              child: _form(state),
                            )
                          : _form(state);
                    }),
          ),
        ),
      ),
    );
  }

  Widget _form(CreateConsultationState state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: widget.withWithCard
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          /// title
          AppContentTitleWidget(
            title: "طلب استشارة قانونية",
            textColor: widget.withWithCard
                ? AppColor.primaryDarkColor
                : AppColor.accentColor,
          ),

          //==> space
          SizedBox(height: Sizes.dimen_8.h),

          /// form
          Form(
            key: _formKey,
            child: Wrap(
              alignment: WrapAlignment.center,
              //spacing: 20, // to apply margin in the main axis of the wrap
              runSpacing: Sizes.dimen_4.h,
              children: [
                /// Consultation title
                AppTextField(
                  controller: titleController,
                  label: "عنوان الاستشارة",
                ),

                /// upload images
                UploadIdImageWidget(
                  text: "ارفق المستندات الخاصة بالاستشارة",
                  onPressed: () => _pickImageCubit.pickMultiImage(),
                ),

                TextFieldLargeContainer(
                  appTextField: AppTextField(
                    controller: descriptionController,
                    label: "اكتب تفاصيل الاستشارة",
                    maxLines: 20,
                    validateOnSubmit: true,
                    withFocusedBorder: false,
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: Sizes.dimen_5.h),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                text:
                    "حتي تحصل على الخدمة بصورة صحيحة برجاء إرفاق المستندات الخاصة بطلبك حتى يتمكن فريقنا من الرد على استفسارك بصورة مهنية. \n",
                style: Theme.of(context).textTheme.caption!.copyWith(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.dimen_10.sp,
                      color: widget.withWithCard
                          ? AppColor.primaryDarkColor
                          : AppColor.white,
                    ),
              ),
              TextSpan(
                text: "قيمة الاستشارة ",
                style: Theme.of(context).textTheme.caption!.copyWith(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.dimen_10.sp,
                      color: widget.withWithCard
                          ? AppColor.primaryDarkColor
                          : AppColor.white,
                    ),
              ),
              TextSpan(
                text: widget.consultFees.toString(),
                style: Theme.of(context).textTheme.caption!.copyWith(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.dimen_14.sp,
                      color: widget.withWithCard
                          ? AppColor.primaryDarkColor
                          : AppColor.white,
                    ),
              ),
              TextSpan(
                text: " جنيه",
                style: Theme.of(context).textTheme.caption!.copyWith(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.dimen_10.sp,
                      color: widget.withWithCard
                          ? AppColor.primaryDarkColor
                          : AppColor.white,
                    ),
              ),
            ])),
          ),

          //==> space
          SizedBox(height: Sizes.dimen_5.h),

          /// loading or show button
          state is LoadingCreateConsultation
              ? const Center(
                  child: LoadingWidget(),
                )
              : AppButton(
                  text: "ارسال",
                  color: AppColor.accentColor,
                  textColor: AppColor.primaryDarkColor,
                  withAnimation: true,
                  width: double.infinity,
                  onPressed: () {
                    if (_isFormValid()) {
                      _sendConsultation();
                    }
                  },
                ),

          //==> space
          SizedBox(height: Sizes.dimen_20.h),
        ],
      ),
    );
  }

  /// send Consultation
  void _sendConsultation() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // init title
    final title = titleController.value.text;

    // init description
    final description = descriptionController.value.text;

    // send create sos request
    _createConsultationCubit.payForConsult(
      title: title,
      description: description,
      consultFees: widget.consultFees,
      imagePaths: _imagesPicked,
      token: userToken,
    );
  }

  /// to validate the current form
  bool _isFormValid() {
    //==> validateOnMultiImages
    _pickImageCubit.validateOnMultiImages();

    if (_imagesPicked.isEmpty) {
      showSnackBar(context,
          isFloating: false,
          backgroundColor: AppColor.accentColor,
          textColor: AppColor.primaryDarkColor,
          message: "ارفاق صورة على الاقل مطلوب");
      return false;
    }

    //==> validate on form and received images list
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }

  /// to navigate to my Consultations screen
  void _onSuccess(PayEntity payEntity) {
    widget.onSuccess(payEntity);
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);
}
