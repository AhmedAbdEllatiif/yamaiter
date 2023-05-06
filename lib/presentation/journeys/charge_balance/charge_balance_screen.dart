import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/logic/cubit/charge_balance_cubit/charge_balance_cubit.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/sizes.dart';
import '../../../common/enum/app_error_type.dart';
import '../../../common/functions/common_functions.dart';
import '../../../common/functions/get_user_token.dart';
import '../../../common/functions/navigate_to_login.dart';
import '../../../common/screen_utils/screen_util.dart';
import '../../../di/git_it_instance.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/loading_widget.dart';

class ChargeBalanceScreen extends StatefulWidget {
  const ChargeBalanceScreen({Key? key}) : super(key: key);

  @override
  State<ChargeBalanceScreen> createState() => _ChargeBalanceScreenState();
}

class _ChargeBalanceScreenState extends State<ChargeBalanceScreen> {
  /// form key
  final _formKey = GlobalKey<FormState>();

  /// _phoneController
  late final TextEditingController _amountToChargeController;

  /// error text
  String? errorText;

  /// PayoutCubit
  late final ChargeBalanceCubit _chargeBalanceCubit;

  @override
  void initState() {
    super.initState();
    _chargeBalanceCubit = getItInstance<ChargeBalanceCubit>();
    _amountToChargeController = TextEditingController();
  }

  @override
  void dispose() {
    _chargeBalanceCubit.close();
    _amountToChargeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _chargeBalanceCubit),
      ],
      child: Scaffold(
          backgroundColor: AppColor.primaryDarkColor,

          /// appBar
          appBar: AppBar(
            title: const Text("شحن المحفظة"),
          ),

          /// body
          body: Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil.screenHeight * 0.05,
              right: AppUtils.mainPagesHorizontalPadding.w,
              left: AppUtils.mainPagesHorizontalPadding.w,
            ),
            child: BlocBuilder<ChargeBalanceCubit, ChargeBalanceState>(
              builder: (context, state) {
                /*
                *
                *
                * UnAuthorized to get balance
                *
                *
                * */
                if (state is UnAuthorizedToChargeBalance) {
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
                * error while getting balance
                *
                *
                * */
                if (state is ErrorWhileChargingBalance) {
                  return Center(
                    child: AppErrorWidget(
                      appTypeError: state.appError.appErrorType,
                      onPressedRetry: () => _tryToChargeUserBalance(),
                    ),
                  );
                }

                /*
                *
                *
                * balance fetched
                *
                *
                * */
                if (state is BalanceChargedSuccessfully) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [

                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "الرقم المرجعي للمدفوعات \n",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.normal,
                                  height: 0.8,
                                ),
                              ),
                              TextSpan(
                                text: "${state.chargeBalanceEntity.billReference}\n",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      height: 2,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.white,
                                    ),
                              ),
                              TextSpan(
                                text:
                                    "طريقة الدفع: برجاء التوجه إلى أقرب فرع أمان أو مصاري أو ممكن أو سداد واسأل عن ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      height: 1.5,
                                      fontWeight: FontWeight.normal,
                                      color: AppColor.white,
                                    ),
                              ),
                              TextSpan(
                                text: "“مدفوعات اكسبت” ",
                                style:
                                    Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          height: 1.5,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.white,
                                        ),
                              ),
                              TextSpan(
                                text: "و أخبرهم بالرقم المرجعي.\n",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      height: 1.5,
                                      fontWeight: FontWeight.normal,
                                      color: AppColor.white,
                                    ),
                              ),
                              TextSpan(
                                text: "تنتهى صلاحية الرقم المرجعى بعد ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                  height: 1.5,
                                  fontWeight: FontWeight.normal,
                                  color: AppColor.white,
                                ),
                              ),

                              TextSpan(
                                text: "24",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                  height: 2,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.white,
                                ),
                              ),

                              TextSpan(
                                text: " ساعة",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                  height: 1.5,
                                  fontWeight: FontWeight.normal,
                                  color: AppColor.white,
                                ),
                              ),

                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                /*
                *
                *
                * else
                *
                *
                * */
                return Column(
                  children: [
                    /// title
                    Text(
                      "شحن المحفظة",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppColor.accentColor,
                                fontWeight: FontWeight.bold,
                              ),
                    ),

                    /// space
                    SizedBox(height: Sizes.dimen_20.h),

                    /// form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //==> phone num
                          AppTextField(
                            label: "ادخل القيمة",
                            textInputType: TextInputType.number,
                            controller: _amountToChargeController,
                          ),

                          //==> space
                          SizedBox(height: Sizes.dimen_5.h),
                        ],
                      ),
                    ),

                    /// space
                    SizedBox(height: Sizes.dimen_10.h),

                    /// button
                    state is LoadingToChargeBalance
                        ? const LoadingWidget()
                        : AppButton(
                            text: "تأكيد",
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    AppUtils.mainPagesHorizontalPadding.w),
                            color: AppColor.accentColor,
                            textColor: AppColor.white,
                            onPressed: () {
                              if (_validate()) {
                                _tryToChargeUserBalance();
                              }
                            },
                          ),
                  ],
                );
              },
            ),
          )),
    );
  }

  /// validate
  bool _validate() {
    final amount = double.tryParse(_amountToChargeController.value.text);

    /// check the amount
    if (amount == null) {
      showSnackBar(context, message: "ادخل مبلغ صحيح");
      return false;
    }

    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }

    return false;
  }

  void _tryToChargeUserBalance() {
    // user token
    final userToken = getUserToken(context);

    // amount
    final amount = double.parse(_amountToChargeController.value.text);

    _chargeBalanceCubit.tryToChargeBalance(
      amount: amount,
      userToken: userToken,
    );
  }
}
