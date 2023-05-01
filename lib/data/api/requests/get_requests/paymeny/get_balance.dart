import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';
import 'package:yamaiter/data/params/payment/get_balance_params.dart';

import '../../../constants.dart';


/// This request used for :
/// 1.Update current user balance in our database.
/// 2.Return the current user balance.
class GetUserBalanceRequest extends GetRequest<GetBalanceParams> {
  @override
  Future<http.Response> call(GetBalanceParams params) async {
    var response = await initGetRequest(
      requestType: RequestType.balance,
      token: params.userToken,
    );
    return response;
  }
}
