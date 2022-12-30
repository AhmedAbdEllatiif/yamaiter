import 'package:yamaiter/data/models/payment/refund_request_model.dart';

class RefundParams {
  final RefundRequestModel model;
  final String userToken;

  RefundParams({
    required this.model,
    required this.userToken,
  });
}
