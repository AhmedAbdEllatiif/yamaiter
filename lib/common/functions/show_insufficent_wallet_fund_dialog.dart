import 'package:flutter/cupertino.dart';

import '../../router/route_helper.dart';
import 'common_functions.dart';

void showInsufficientWalletFundDialog(BuildContext context) {
  showAppDialog(context,
      message: "رصيد المحفظة غير كافٍ",
      buttonText: "شحن المحفظة", onPressed: () {
    RouteHelper().chargeBalanceScreen(context);
  });
}
