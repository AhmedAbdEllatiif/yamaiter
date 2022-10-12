import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';
import 'package:yamaiter/data/params/all_sos_params.dart';
import 'package:yamaiter/data/params/all_sos_params.dart';

import '../../constants.dart';

class GetAllSosRequest extends GetRequest<GetAllSosParams> {
  @override
  Future<http.Response> call(GetAllSosParams params) async {
    var response = await initGetRequest(
        requestType: RequestType.allSosList,
        token: params.userToken,
        queryParams: {
          ApiParamsConstant.offset: params.offset.toString(),
        });
    return response;
  }
}
