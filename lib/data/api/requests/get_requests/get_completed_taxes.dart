import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';

import '../../../params/get_taxes_params.dart';
import '../../api_constants.dart';
import '../../request_type.dart';

class GetCompletedTaxesRequest extends GetRequest<GetTaxesParams> {
  @override
  Future<http.Response> call(GetTaxesParams params) async {
    var response = await initGetRequest(
        requestType: RequestType.completedTaxes,
        token: params.userToken,
        queryParams: {
          ApiParamsConstant.offset: params.offset.toString(),
        });
    return response;
  }
}
