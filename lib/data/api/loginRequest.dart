import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/post_request.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_response.dart';

class LoginRequest extends PostRequest<LoginRequestModel> {

  @override
  Future<http.MultipartRequest> call(LoginRequestModel params) async {
    var request = initPostRequest(RequestType.login, "");
    request.fields["credentials"] = params.email;
    request.fields["password"] = params.password;
    request.fields["remember_me"] = params.rememberMe;
    return request;
  }
}
