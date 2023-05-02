import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/params/update_sos_params.dart';

import '../../request_type.dart';
class UpdateSosRequest extends RawPostRequest<UpdateSosParams, String> {
  @override
  Future<http.Response> call(UpdateSosParams params, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.updateSos,
      body: params.sosRequestModel.toJson(),
      token: token,
      id: params.sosId.toString(),
    );

    return response;
  }
}
