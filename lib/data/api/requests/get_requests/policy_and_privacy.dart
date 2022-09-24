import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';

import '../../constants.dart';

class GetPrivacyRequest extends GetRequest<String> {
  @override
  Future<http.Response> call(String userToken) async {
    var response = await initGetRequest(
        requestType: RequestType.privacyAndPolicy, token: userToken);
    return response;
  }
}
