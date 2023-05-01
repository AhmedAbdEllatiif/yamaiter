import 'package:flutter/material.dart';
import 'package:yamaiter/common/enum/payment_method.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
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

          AppButton(
            text: "تأكيد",
            width: ScreenUtil.screenWidth * 0.5,
            color: AppColor.accentColor,
            onPressed: () {
              widget.onPaymentMethodSelected(_selectedOption);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
