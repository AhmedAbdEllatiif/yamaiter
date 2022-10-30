import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/reigster_lawyer/upload_id_image.dart';
import 'package:yamaiter/presentation/logic/cubit/create_tax/create_tax_cubit.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/enum/app_error_type.dart';
import '../../../common/functions/common_functions.dart';
import '../../../di/git_it.dart';
import '../../../router/route_helper.dart';
import '../../logic/cubit/pick_images/pick_image_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_content_title_widget.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/scrollable_app_card.dart';
import '../../widgets/text_field_large_container.dart';

class CreateTaxForm extends StatefulWidget {
  final Function() onSuccess;
  final bool withWhiteCard;
  final CreateTaxCubit? createTaxCubit;

  const CreateTaxForm({
    Key? key,
    required this.onSuccess,
    required this.withWhiteCard,
    this.createTaxCubit,
  }) : super(key: key);

  @override
  State<CreateTaxForm> createState() => _CreateTaxFormState();
}

class _CreateTaxFormState extends State<CreateTaxForm> {
  late final CreateTaxCubit _createTaxCubit;

  /// imagerPicker cubit
  late final PickImageCubit _pickImageCubit;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  String _taxImage = '';

  @override
  void initState() {
    super.initState();
    _createTaxCubit = widget.createTaxCubit ?? getItInstance<CreateTaxCubit>();
    _pickImageCubit = getItInstance<PickImageCubit>();
  }

  @override
  void dispose() {
    if (widget.createTaxCubit == null) {
      _createTaxCubit.close();
    }
    _pickImageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _createTaxCubit),
        BlocProvider(create: (_) => _pickImageCubit),
      ],
      child: MultiBlocListener(
          listeners: [
            /// PickImageCubit
            BlocListener<PickImageCubit, PickImageState>(
              listener: (context, state) {
                if (state is ImagePicked) {
                  _taxImage = state.image.path;
                }
              },
            ),

            BlocListener<CreateTaxCubit, CreateTaxState>(
              bloc: _createTaxCubit,
                listener: (_, state) {
              /// show snackBar on bTaxInternetConnection
              if (state is ErrorWhileCreatingTax) {
                showSnackBar(context,
                    backgroundColor: AppColor.accentColor,
                    textColor: AppColor.primaryDarkColor,
                    isFloating: false,
                    message: "تحقق من اتصال الإنترنت");
              }

              /// success
              if (state is TaxCreatedSuccessfully) {
                _navigateToMyTaxes();
              }
            })
          ],
          child: widget.withWhiteCard
              ? ScrollableAppCard(
                  child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// title
                      const AppContentTitleWidget(
                          title: "طلب خدمة الاقرار الضريبى"),

                      /// form
                      Padding(
                        padding: EdgeInsets.only(top: Sizes.dimen_5.h),
                        child: _form(),
                      ),
                    ],
                  ),
                ))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// title
                    AppContentTitleWidget(
                      title: "طلب اقرار ضريبى",
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
                )),
    );
  }

  Widget _form() {
    return Column(
      children: [
        /// Tax pages
        Form(
          key: _formKey,
          child: Wrap(
            alignment: WrapAlignment.center,
            //spacing: 20, // to apply margin in the main axis of the wrap
            runSpacing: Sizes.dimen_4.h,
            children: [
              /// upload
              UploadIdImageWidget(
                text: "صورة البطاقة الضريبية",
                onPressed: () => _pickImageCubit.pickSingleImage(),
              ),

              /// tax name
              AppTextField(
                controller: nameController,
                label: "اسم المستخدم الضريبى",
              ),

              /// tax password
              AppTextField(
                controller: passwordController,
                label: "كلمة مرور التسجيل الضريبى",
              ),

              TextFieldLargeContainer(
                appTextField: AppTextField(
                  controller: notesController,
                  label: "ملاحظات اضافية",
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
          child: Text(
            "تكلفة خدمة الاقرار الضريبي 150 جنيه فقط.\n"
            "قم بإرفاق الملف الضريبى و سيعمل فريق عملنا علي انجازه و تقديمه فى مدة لا تتعدى 3 ايام",
            style: Theme.of(context).textTheme.caption!.copyWith(
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                  fontSize: Sizes.dimen_10.sp,
                  color: widget.withWhiteCard
                      ? AppColor.primaryDarkColor
                      : AppColor.white,
                ),
          ),
        ),

        /// space
        SizedBox(height: Sizes.dimen_5.h),

        /// button
        SizedBox(
          width: double.infinity,
          child: BlocBuilder<CreateTaxCubit, CreateTaxState>(
            bloc: _createTaxCubit,
            builder: (context, state) {
              if (state is LoadingCreateTax) {
                return const Center(
                  child: LoadingWidget(),
                );
              }

              /// UnAuthorizedCreateSos
              if (state is UnAuthorizedCreateTax) {
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
              if (state is NotActivatedUserToCreateTax) {
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
                text: "اطلب الخدمة",
                color: AppColor.accentColor,
                textColor: AppColor.primaryDarkColor,
                onPressed: () {
                  if (_isFormValid()) {
                    _sendCreateTaxRequest();
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  /// to send create Tax request
  void _sendCreateTaxRequest() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // init params
    final taxImage = _taxImage;
    final taxName = nameController.value.text;
    final taxPassword = passwordController.value.text;
    final note = notesController.value.text;

    // send a request
    _createTaxCubit.createTax(
        taxName: taxName,
        taxPassword: taxPassword,
        taxFile: taxImage,
        note: note,
        token: userToken);
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate on success
  void _navigateToMyTaxes() {
    widget.onSuccess();
  }

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);

  /// to validate the current form
  bool _isFormValid() {
    /// validate on image
    _pickImageCubit.validateOnSingleImage();

    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }
}
