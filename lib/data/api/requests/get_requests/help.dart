import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';

import '../../constants.dart';

class GetAboutRequest extends GetRequest<String> {
  @override
  Future<http.Request> call(String userToken) async {
    var request =
        initGetRequest(requestType: RequestType.help, token: userToken);
    return request;
  }
}
