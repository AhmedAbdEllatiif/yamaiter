import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/common/enum/pay_out_type.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/get_user_token.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/presentation/logic/common/get_balance/get_balance_cubit.dart';
import 'package:yamaiter/presentation/logic/common/payout/payout_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_drop_down_field.dart';
import 'package:yamaiter/presentation/widgets/app_error_widget.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/sizes.dart';
import '../../../common/functions/common_functions.dart';
import '../../../common/functions/navigate_to_login.dart';
import '../../../common/functions/pay_out_type_list.dart';
import '../../../common/screen_utils/screen_util.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class PayoutScreen extends StatefulWidget {
  const PayoutScreen({Key? key}) : super(key: key);

  @override
  State<PayoutScreen> createState() => _PayoutScreenState();
}

class _PayoutScreenState extends State<PayoutScreen> {
  /// form key
  final _formKey = GlobalKey<FormState>();

  /// _phoneController
  late final TextEditingController _phoneController;

  /// PayoutType
  PayoutType _payoutType = PayoutType.unKnown;

  /// PayoutTypeList
  final payoutTypes = getPayoutTypeList();

  /// error text
  String? errorText;

  /// PayoutCubit
  late final PayoutCubit _payoutCubit;

  /// GetBalanceCubit
  late final GetBalanceCubit _balanceCubit;

  @override
  void initState() {
    super.initState();
    _payoutCubit = getItInstance<PayoutCubit>();
    _balanceCubit = getItInstance<GetBalanceCubit>();
    _phoneController = TextEditingController();
    _fetchCurrentBalance();
  }

  @override
  void dispose() {
    _payoutCubit.close();
    _balanceCubit.close();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _balanceCubit),
        BlocProvider(create: (context) => _payoutCubit),
      ],
      child: Scaffold(
          backgroundColor: AppColor.primaryDarkColor,

          /// appBar
          appBar: AppBar(
            title: const Text("استلام النقود"),
          ),

          /// body
          body: Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil.screenHeight * 0.05,
              right: AppUtils.mainPagesHorizontalPadding.w,
              left: AppUtils.mainPagesHorizontalPadding.w,
            ),
            child: BlocBuilder<GetBalanceCubit, GetBalanceState>(
              builder: (context, balanceState) {
                /*
                *
                *
                * loading balance
                *
                *
                * */
                if (balanceState is LoadingBalance) {
                  return const Center(
                    child: LoadingWidget(),
                  );
                }

                /*
                *
                *
                * UnAuthorized to get balance
                *
                *
                * */
                if (balanceState is UnAuthorizedGetBalance) {
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
                if (balanceState is ErrorWhileFetchingBalance) {
                  return Center(
                    child: AppErrorWidget(
                      appTypeError: balanceState.appError.appErrorType,
                      onPressedRetry: () => _fetchCurrentBalance(),
                    ),
                  );
                }

                /*
                *
                *
                * no balance
                *
                *
                * */
                if (balanceState is UserHaveNoBalance) {
                  return Center(
                    child: Text(
                      "0",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: AppColor.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
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
                if (balanceState is BalanceFetchedSuccessfully) {
                  return Column(
                    children: [
                      /// available balance
                      Text(
                        "الرصيد المتاح",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: AppColor.white,
                              fontWeight: FontWeight.bold,
                              height: 0.8,
                            ),
                      ),

                      /// title
                      Text(
                        "${balanceState.balanceEntity.currentBalance}",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: AppColor.accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),

                      /// space
                      SizedBox(height: Sizes.dimen_20.h),

                      /// title
                      Text(
                        "اختر طريقة استلام النقود",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: AppColor.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),

                      /// space
                      SizedBox(height: Sizes.dimen_10.h),

                      /// form
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            //==> phone num
                            AppTextField(
                              label: "رقم الهاتف المحمول",
                              textInputType: TextInputType.number,
                              maxLength: 11,
                              minLength: 11,
                              controller: _phoneController,
                            ),

                            //==> space
                            SizedBox(height: Sizes.dimen_5.h),

                            //==>  dropdown
                            AppDropDownField(
                              itemsList: payoutTypes.values.toList(),
                              hintText: "طرق استلام النقود",
                              errorText: errorText,
                              onChanged: (value) {
                                _payoutType = payoutTypes.keys.firstWhere(
                                  (k) => payoutTypes[k] == value,
                                  orElse: () => PayoutType.unKnown,
                                );
                                _validate();
                              },
                            ),
                          ],
                        ),
                      ),

                      /// space
                      SizedBox(height: Sizes.dimen_10.h),

                      /// button
                      BlocBuilder<PayoutCubit, PayoutState>(
                        builder: (context, state) {
                          /*
                    *
                    *
                    * loading
                    *
                    *
                    * */
                          if (state is LoadingPayout) {
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
                          if (state is UnAuthorizedToSendPayout) {
                            return AppErrorWidget(
                              appTypeError: AppErrorType.unauthorizedUser,
                              onPressedRetry: () => navigateToLogin(context),
                            );
                          }

                          /*
                    *
                    *
                    * no amount
                    *
                    *
                    * */
                          if (state is NoAmountToPayout) {
                            return AppErrorWidget(
                              appTypeError: AppErrorType.noWithdrawalAmount,
                              message: "لا يوجد اى مستحقات",
                              onPressedRetry: () => _tryToSendPayout(),
                            );
                          }

                          /*
                    *
                    *
                    * error
                    *
                    *
                    * */
                          if (state is ErrorWhileSendingPayout) {
                            return AppErrorWidget(
                              appTypeError: state.appError.appErrorType,
                              onPressedRetry: () => _tryToSendPayout(),
                            );
                          }

                          /// else
                          return AppButton(
                            text: "تأكيد",
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    AppUtils.mainPagesHorizontalPadding.w),
                            color: AppColor.accentColor,
                            textColor: AppColor.white,
                            onPressed: () {
                              if (_validate()) {
                                _tryToSendPayout();
                              }
                            },
                          );
                        },
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          )),
    );
  }

  /// validate that payout is selected
  bool _validate() {
    /// check phone number
    if (_phoneController.value.text.length != 11) {
      showSnackBar(context, message: "رقم هاتف غير صحيح");
      return false;
    }

    /// check payment
    if (_payoutType == PayoutType.unKnown) {
      setState(() {
        errorText = "* اختر طريقة استلام النقود";
      });
    } else {
      setState(() {
        errorText = null;
      });
    }

    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }

    return false;
  }

  void _fetchCurrentBalance() {
    final userToken = getUserToken(context);
    _balanceCubit.tryToGetUserBalance(userToken: userToken);
  }

  /// to send request
  void _tryToSendPayout() {
    final userToken = getUserToken(context);
    final phoneNum = _phoneController.value.text;

    _payoutCubit.tryToSendPayout(
      userToken: userToken,
      method: _payoutType.toShortString(),
      phoneNum: phoneNum,
    );
  }
}
