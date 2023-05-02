import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/models/tasks/update_task_request_model.dart';

import '../../request_type.dart';

class UpdateTaskRequest extends RawPostRequest<UpdateTaskRequestModel, String> {
  @override
  Future<http.Response> call(
      UpdateTaskRequestModel params, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.updateTask,
      body: params.toJson(),
      id: params.id.toString(),
      token: token,
    );

    return response;
  }
}
