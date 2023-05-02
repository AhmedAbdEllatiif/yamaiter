import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';

import '../../request_type.dart';

class GetContactUsRequest extends GetRequest<String> {
  @override
  Future<http.Response> call(String params) async {
    var response = await initGetRequest(
        requestType: RequestType.contactUs, token: params);
    return response;
  }
}
