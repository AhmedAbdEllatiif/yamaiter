import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';

import '../../../../models/tasks/client/update_task_request_model.dart';

class UpdateTaskClientRequest extends RawPostRequest<UpdateTaskClientRequestModel, String> {
  @override
  Future<http.Response> call(
      UpdateTaskClientRequestModel params, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.updateTaskClient,
      body: params.toJson(),
      id: params.id.toString(),
      token: token,
    );

    return response;
  }
}
