import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';

import '../../../params/get_single_sos_params.dart';
import '../../request_type.dart';

class GetMySingleSosRequest extends GetRequest<GetSingleSosParams> {
  @override
  Future<http.Response> call(GetSingleSosParams params) async {
    var response = await initGetRequest(
      requestType: RequestType.singleSos,
      token: params.userToken,
      id: params.sosId.toString(),
    );
    return response;
  }
}
