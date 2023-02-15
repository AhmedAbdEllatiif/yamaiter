import '../../models/payment/pay_out_request_model.dart';

class PayoutParams {
  final String userToken;
  final String method;
  final String phone;


  PayoutParams({
    required this.userToken,
    required this.method,
    required this.phone,
  });
}
