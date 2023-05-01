import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/payment_method.dart';
import 'package:yamaiter/common/functions/common_functions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../common/functions/get_user_token.dart';
import '../../di/git_it_instance.dart';
import '../logic/common/get_balance/get_balance_cubit.dart';

class ChoosePaymentMethodDialog extends StatefulWidget {
  final Function(PaymentMethod) onPaymentMethodSelected;

  const ChoosePaymentMethodDialog({
    Key? key,
    required this.onPaymentMethodSelected,
  }) : super(key: key);

  @override
  State<ChoosePaymentMethodDialog> createState() =>
      _ChoosePaymentMethodDialogState();
}

class _ChoosePaymentMethodDialogState extends State<ChoosePaymentMethodDialog> {
  PaymentMethod _selectedOption = PaymentMethod.card;

  /// GetBalanceCubit
  late final GetBalanceCubit _balanceCubit;

  @override
  void initState() {
    super.initState();
    _balanceCubit = getItInstance<GetBalanceCubit>();
  }

  @override
  void dispose() {
    _balanceCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _balanceCubit,
      child: BlocListener<GetBalanceCubit, GetBalanceState>(
        listener: (context, state) {
          /// balance updated successfully
          if (state is BalanceFetchedSuccessfully) {
            widget.onPaymentMethodSelected(_selectedOption);
            Navigator.pop(context);
          }

          /// error while updating balance
          if (state is ErrorWhileFetchingBalance) {
            Navigator.pop(context);
            showSnackBar(context, message: "حدث خطأ، اعد المحاولة لاحقا");
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "اختر طريقة الدفع",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),

              // payment methods
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: PaymentMethod.values.length,
                separatorBuilder: (_, __) => const SizedBox(height: 1),
                itemBuilder: (context, index) {
                  return RadioListTile<PaymentMethod>(
                    title: Text(
                      PaymentMethod.values[index].toShortArabicString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColor.white,
                          ),
                    ),
                    value: PaymentMethod.values[index],
                    groupValue: _selectedOption,
                    onChanged: (PaymentMethod? value) {
                      if (value != null) {
                        setState(() {
                          _selectedOption = value;
                        });
                      }
                    },
                  );
                },
              ),

              BlocBuilder<GetBalanceCubit, GetBalanceState>(
                builder: (context, state) {
                  return state is LoadingBalance
                      ? const LoadingWidget()
                      : AppButton(
                          text: "تأكيد",
                          width: ScreenUtil.screenWidth * 0.5,
                          color: AppColor.accentColor,
                          onPressed: () {
                            if (_selectedOption == PaymentMethod.kiosk) {
                              _fetchCurrentBalance();
                            } else {
                              widget.onPaymentMethodSelected(_selectedOption);
                              Navigator.pop(context);
                            }
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _fetchCurrentBalance() {
    final userToken = getUserToken(context);
    _balanceCubit.tryToGetUserBalance(userToken: userToken);
  }
}
