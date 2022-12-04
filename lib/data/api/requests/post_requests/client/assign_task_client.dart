import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/params/client/assign_task_params_client.dart';

class AssignTaskClientRequest
    extends RawPostRequest<AssignTaskParamsClient, String> {
  @override
  Future<http.Response> call(
      AssignTaskParamsClient params, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.assignTaskClient,
      body: params.toJson(),
      token: token,
    );

    return response;
  }
}
