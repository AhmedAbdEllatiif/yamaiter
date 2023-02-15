import 'package:yamaiter/data/params/payment/pay_out_params.dart';

class PayoutRequestModel {
  final String method;
  final String phone;

  PayoutRequestModel({required this.method, required this.phone});

  factory PayoutRequestModel.fromParams({required PayoutParams params}) {
    return PayoutRequestModel(method: params.method, phone: params.phone);
  }

  Map<String, String> toJson() {
    return {
      "method": method,
      "phone": phone,
    };
  }
}
