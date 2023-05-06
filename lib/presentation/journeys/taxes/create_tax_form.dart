import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/payment_method.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/pay_entity.dart';
import 'package:yamaiter/presentation/journeys/reigster_lawyer/upload_id_image.dart';
import 'package:yamaiter/presentation/logic/cubit/pay_for_tax/pay_for_tax_cubit.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/enum/app_error_type.dart';
import '../../../common/functions/common_functions.dart';
import '../../../common/functions/show_choose_payment_method_dialog.dart';
import '../../../common/functions/show_insufficent_wallet_fund_dialog.dart';
import '../../../di/git_it_instance.dart';
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
  final Function(PayEntity) onSuccess;
  final bool withWhiteCard;
  final PayForTaxCubit? payForTaxCubit;
  final double taxValue;
  final String costCommission;

  const CreateTaxForm({
    Key? key,
    required this.onSuccess,
    required this.withWhiteCard,
    required this.costCommission,
    this.payForTaxCubit,
    required this.taxValue,
  }) : super(key: key);

  @override
  State<CreateTaxForm> createState() => _CreateTaxFormState();
}

class _CreateTaxFormState extends State<CreateTaxForm> {
  late final PayForTaxCubit _payForTaxCubit;

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
    _payForTaxCubit = widget.payForTaxCubit ?? getItInstance<PayForTaxCubit>();
    _pickImageCubit = getItInstance<PickImageCubit>();
  }

  @override
  void dispose() {
    if (widget.payForTaxCubit == null) {
      _payForTaxCubit.close();
    }
    _pickImageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _payForTaxCubit),
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

            BlocListener<PayForTaxCubit, PayForTaxState>(
                bloc: _payForTaxCubit,
                listener: (_, state) {
                  /// show snackBar on bTaxInternetConnection
                  if (state is ErrorWhileCreatingTax) {
                    showSnackBar(context,
                        backgroundColor: AppColor.accentColor,
                        textColor: AppColor.primaryDarkColor,
                        isFloating: false,
                        message: "حدث خطأ، اعد المحاولة لاحقا");
                  }

                  /// payment link is ready
                  if (state is TaxPaymentLinkIsReady) {
                    _navigateToPayment(state.payEntity);
                  }

                  /// success with wallet
                  if (state is TaxPayedSuccessfullyWithWallet) {
                    _navigateToMyTaxes();
                  }

                  /// insufficient wallet fund
                  if (state is InsufficientWalletFundToPayForTax) {
                    showInsufficientWalletFundDialog(context);
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
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
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
                  ),
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
                minLength: 5,
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
                  minLength: 5,
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
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'تكلفة خدمة الاقرار الضريبي  ',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.dimen_10.sp,
                        color: widget.withWhiteCard
                            ? AppColor.primaryDarkColor
                            : AppColor.white,
                      ),
                ),
                TextSpan(
                  text: '${widget.taxValue}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.dimen_14.sp,
                        color: widget.withWhiteCard
                            ? AppColor.primaryDarkColor
                            : AppColor.white,
                      ),
                ),
                TextSpan(
                  text: ' جنيه +  ',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.dimen_10.sp,
                        color: widget.withWhiteCard
                            ? AppColor.primaryDarkColor
                            : AppColor.white,
                      ),
                ),
                TextSpan(
                  text: widget.costCommission,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.dimen_14.sp,
                        color: widget.withWhiteCard
                            ? AppColor.primaryDarkColor
                            : AppColor.white,
                      ),
                ),
                TextSpan(
                  text: ' عمولة',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.dimen_10.sp,
                        color: widget.withWhiteCard
                            ? AppColor.primaryDarkColor
                            : AppColor.white,
                      ),
                ),
                TextSpan(
                  text:
                      '\n قم بإرفاق الملف الضريبى و سيعمل فريق عملنا علي انجازه و تقديمه فى مدة لا تتعدى 3 ايام',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.dimen_10.sp,
                        color: widget.withWhiteCard
                            ? AppColor.primaryDarkColor
                            : AppColor.white,
                      ),
                ),
              ],
            ),
          ),
        ),

        /// space
        SizedBox(height: Sizes.dimen_5.h),

        /// button
        SizedBox(
          width: double.infinity,
          child: BlocBuilder<PayForTaxCubit, PayForTaxState>(
            bloc: _payForTaxCubit,
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
                    showChoosePaymentMethodDialog(context,
                        onPaymentMethodSelected: (paymentMethod) {
                      _sendCreateTaxRequest(paymentMethod: paymentMethod);
                    });
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
  void _sendCreateTaxRequest({required PaymentMethod paymentMethod}) {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // init params
    final taxImage = _taxImage;
    final taxName = nameController.value.text;
    final taxPassword = passwordController.value.text;
    final note = notesController.value.text;
    final value = widget.taxValue;

    // send a request
    _payForTaxCubit.tryToPayForTax(
      taxName: taxName,
      taxPassword: taxPassword,
      taxFile: taxImage,
      note: note,
      value: value,
      token: userToken,
      paymentMethod: paymentMethod,
    );
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate on success
  void _navigateToPayment(PayEntity paymentLink) {
    widget.onSuccess(paymentLink);
  }

  /// to navigate to my taxes screen
  void _navigateToMyTaxes() {
    RouteHelper().myTaxesScreen(context, isReplacement: true);
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
