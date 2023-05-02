import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/params/payment/refund_params.dart';

import '../../../request_type.dart';
class RefundRequest extends RawPostRequest<RefundParams, String> {
  @override
  Future<http.Response> call(RefundParams params, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.refund,
      body: params.model.toJson(),
      token: token,
    );

    return response;
  }
}
