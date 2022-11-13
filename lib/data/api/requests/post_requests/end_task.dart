import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/models/tasks/end_task_request_model.dart';
import 'package:yamaiter/data/params/end_task_params.dart';

class EndTaskRequest extends RawPostRequest<EndTaskParams, String> {
  @override
  Future<http.Response> call(EndTaskParams params, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.endTask,
      body: EndTaskRequestModel(rating: params.rating).toJson(),
      token: token,
      id: params.taskId.toString(),
    );

    return response;
  }
}
