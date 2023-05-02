import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/models/auth/register_client/register_client_request_model.dart';
import 'package:yamaiter/data/params/no_params.dart';

import '../../../request_type.dart';
class RegisterClientRequest
    extends RawPostRequest<RegisterClientRequestModel, NoParams> {
  @override
  Future<http.Response> call(
      RegisterClientRequestModel params, NoParams token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.registerClient,
      body: params.toJson(),
      token: "",
    );

    return response;
  }
}
