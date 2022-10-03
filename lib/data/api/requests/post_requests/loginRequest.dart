import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/multi_part_post_request.dart';


import '../../../models/auth/login/login_request.dart';

class LoginRequest extends MultiPartPostRequest<LoginRequestModel> {

  @override
  Future<http.MultipartRequest> call(LoginRequestModel params) async {
    var request = initMultiPartPostRequest(requestType:RequestType.login, token: "");
    request.fields["credentials"] = params.email;
    request.fields["password"] = params.password;
    request.fields["remember_me"] = params.rememberMe;
    return request;
  }
}
