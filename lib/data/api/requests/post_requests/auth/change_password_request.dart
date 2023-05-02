import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/api_constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/models/auth/change_password/change_password_request_model.dart';
import 'package:yamaiter/data/params/change_password_params.dart';

import '../../../request_type.dart';
class ChangePasswordRequest
    extends RawPostRequest<ChangePasswordParams, String> {
  @override
  Future<http.Response> call(ChangePasswordParams params, String token) async {
    //==> init request model
    final requestModel = ChangePasswordRequestModel.fromParams(params: params);

    var response = await initRawPostRequest(
      requestType: RequestType.changePassword,
      body: requestModel.toJson(),
      token: token,
    );

    return response;
  }
}
