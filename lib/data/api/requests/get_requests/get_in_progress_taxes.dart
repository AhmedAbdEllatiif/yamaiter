import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';

import '../../../params/get_taxes_params.dart';
import '../../constants.dart';

class GetInProgressTaxesRequest extends GetRequest<GetTaxesParams> {
  @override
  Future<http.Response> call(GetTaxesParams params) async {
    var response = await initGetRequest(
        requestType: RequestType.inProgressTaxes,
        token: params.userToken,
        queryParams: {
          ApiParamsConstant.offset: params.offset.toString(),
        });
    return response;
  }
}
