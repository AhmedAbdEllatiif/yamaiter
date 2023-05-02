import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/params/apply_for_task.dart';

import '../../request_type.dart';

class ApplyForTaskRequest extends RawPostRequest<ApplyForTaskParams, String> {
  @override
  Future<http.Response> call(ApplyForTaskParams params, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.applyForTask,
      body: params.toJson(),
      token: token,
      id: params.taskId.toString(),
    );

    return response;
  }
}
