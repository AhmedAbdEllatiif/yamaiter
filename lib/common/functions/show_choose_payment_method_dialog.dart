import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../presentation/themes/theme_color.dart';
import '../../presentation/widgets/choose_payment_method_dialog.dart';
import '../constants/sizes.dart';
import '../enum/payment_method.dart';

/// To show  dialog
void showChoosePaymentMethodDialog(
  BuildContext context, {
  required Function(PaymentMethod) onPaymentMethodSelected,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColor.primaryColor,
        elevation: Sizes.dimen_32,
        insetPadding: EdgeInsets.all(Sizes.dimen_10.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.dimen_10.w),
          ),
        ),
        child: ChoosePaymentMethodDialog(
          onPaymentMethodSelected: onPaymentMethodSelected,
        ),
      );
    },
  );
}
