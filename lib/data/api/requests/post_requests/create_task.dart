import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';

import '../../../models/tasks/create_task_request_model.dart';
import '../../request_type.dart';

class CreateTaskRequest extends RawPostRequest<CreateTaskRequestModel, String> {
  @override
  Future<http.Response> call(
      CreateTaskRequestModel params, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.createTask,
      body: params.toJson(),
      token: token,
    );

    return response;
  }
}
