import 'package:yamaiter/data/models/payment_status/chech_payment_status_request_model.dart';

class CheckPaymentStatusParams {
  final CheckPaymentStatusModel model;
  final String userToken;

  CheckPaymentStatusParams({
    required this.model,
    required this.userToken,
  });
}
