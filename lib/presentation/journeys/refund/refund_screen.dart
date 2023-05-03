import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/common/enum/payment_mission_type.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/entities/screen_arguments/refund_args.dart';
import 'package:yamaiter/presentation/logic/common/refund_payment/refund_payment_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_error_widget.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../common/constants/sizes.dart';
import '../../../router/route_helper.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../widgets/app_button.dart';

class RefundScreen extends StatefulWidget {
  final RefundArguments refundArguments;

  const RefundScreen({
    Key? key,
    required this.refundArguments,
  }) : super(key: key);

  @override
  State<RefundScreen> createState() => _RefundScreenState();
}

class _RefundScreenState extends State<RefundScreen> {
  /// RefundPaymentCubit
  late final RefundPaymentCubit _refundPaymentCubit;

  /// PaymentMissionType
  late final PaymentMissionType _paymentMissionType;

  /// missionId
  late final int _missionId;

  /// _refundFees
  late final String _refundFees;

  @override
  void initState() {
    super.initState();
    _refundPaymentCubit = widget.refundArguments.refundPaymentCubit;
    _paymentMissionType = widget.refundArguments.paymentMissionType;
    _missionId = widget.refundArguments.missionId;
    _refundFees = widget.refundArguments.refundFees;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,

      // appBar
      appBar: AppBar(),

      // body
      body: BlocConsumer<RefundPaymentCubit, RefundPaymentState>(
        bloc: _refundPaymentCubit,
        //==> listener
        listener: (_, state) {
          if (state is RefundSuccess) {
            _onRefundSuccess();
          }
        },

        //==> builder
        builder: (_, state) {
          /*
        *
        *
        *
        *  unAuthorized
        *
        *
        * */
          if (state is UnAuthorizedRefundPayment) {
            return Center(
              child: AppErrorWidget(
                appTypeError: AppErrorType.unauthorizedUser,
                onPressedRetry: () => _navigateToLogin(),
              ),
            );
          }

          /*
        *
        *
        *
        *  error
        *
        *
        * */
          if (state is ErrorWhileRefundingPayment) {
            return Center(
              child: AppErrorWidget(
                appTypeError: state.appError.appErrorType,
                onPressedRetry: () => _refundPayment(),
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// title
                Text(
                  "حذف المهمة",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColor.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),

                SizedBox(
                  height: Sizes.dimen_8.h,
                ),



                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:  "هل انت متاكد من حذف هذه المهمة\n",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                          color: AppColor.white,
                        ),
                      ),
                      TextSpan(
                        text: 'سيتم خص ',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                          color:AppColor.white,
                        ),
                      ),
                      TextSpan(
                        text: " $_refundFees ",
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                          color:  AppColor.white,
                        ),
                      ),

                      TextSpan(
                        text: 'من المبلغ المدفوع',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                          color:AppColor.white,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: Sizes.dimen_8.h,
                ),

                state is LoadingRefundPayment
                    ? const LoadingWidget()
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Sizes.dimen_30.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: AppButton(
                              text: "حذف المهمة",
                              color: AppColor.accentColor,
                              textColor: AppColor.white,
                              fontSize: Sizes.dimen_16.sp,
                              padding: EdgeInsets.zero,
                              onPressed: () => _refundPayment(),
                            )),
                            SizedBox(
                              width: Sizes.dimen_10.w,
                            ),
                            Expanded(
                              child: AppButton(
                                text: "إلغاء",
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onRefundSuccess() {
    widget.refundArguments.onRefundSuccess ?? Navigator.pop(context);
  }

  void _refundPayment() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _refundPaymentCubit.refundPayment(
      missionType: _paymentMissionType,
      missionId: _missionId,
      token: userToken,
    );
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);
}
