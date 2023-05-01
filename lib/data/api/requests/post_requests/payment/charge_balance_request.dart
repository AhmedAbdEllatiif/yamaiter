import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/models/payment/charge_balance/charge_balance_request_model.dart';
import 'package:yamaiter/data/params/payment/charge_balance_params.dart';

class ChargeBalanceRequest extends RawPostRequest<ChargeBalanceParams, String> {
  @override
  Future<http.Response> call(ChargeBalanceParams params, String token) async {
    //==> init request model
    final model = ChargeBalanceRequestModel.fromParams(params);
    var response = await initRawPostRequest(
      requestType: RequestType.chargeBalance,
      body: model.toJson(),
      token: token,
    );

    return response;
  }
}
