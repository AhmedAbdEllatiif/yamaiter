import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/models/tasks/client/create_task_request_model_client.dart';

class CreateTaskClientRequest
    extends RawPostRequest<CreateTaskRequestModelClient, String> {
  @override
  Future<http.Response> call(
      CreateTaskRequestModelClient params, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.createTaskClient,
      body: params.toJson(),
      token: token,
    );

    return response;
  }
}
