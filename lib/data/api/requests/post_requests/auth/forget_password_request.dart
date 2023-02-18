import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/models/auth/forget_password/forget_password_request_model.dart';
import 'package:yamaiter/data/params/forget_password_params.dart';

class ForgetPasswordRequest
    extends RawPostRequest<ForgetPasswordParams, String> {
  @override
  Future<http.Response> call(ForgetPasswordParams params, String token) async {
    //==> init request model
    final requestModel = ForgetPasswordRequestModel.fromParams(params: params);

    var response = await initRawPostRequest(
      requestType: RequestType.forgetPassword,
      body: requestModel.toJson(),
      token: "",
    );

    return response;
  }
}
