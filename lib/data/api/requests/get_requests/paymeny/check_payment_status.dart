import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';
import 'package:yamaiter/data/params/payment/check_payment_status_params.dart';

import '../../../constants.dart';

class CheckPaymentStatusRequest extends GetRequest<CheckPaymentStatusParams> {
  @override
  Future<http.Response> call(CheckPaymentStatusParams params) async {
    var response = await initGetRequest(
      requestType: RequestType.checkPaymentStatus,
      queryParams:  params.model.toJson(),
      token: params.userToken,
    );
    return response;
  }
}
