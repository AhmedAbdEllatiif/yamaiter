import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/models/payment/pay_out_request_model.dart';
import 'package:yamaiter/data/params/payment/pay_out_params.dart';

import '../../../request_type.dart';
class PayoutRequest extends RawPostRequest<PayoutParams, String> {
  @override
  Future<http.Response> call(PayoutParams params, String token) async {
    //==> init request model
    final model = PayoutRequestModel.fromParams(params: params);
    var response = await initRawPostRequest(
      requestType: RequestType.payout,
      body: model.toJson(),
      token: token,
    );

    return response;
  }
}
