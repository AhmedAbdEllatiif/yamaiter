import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/models/invite_to_task_request_model.dart';
import 'package:yamaiter/data/params/invite_to_task_params.dart';
import '../../request_type.dart';
class InviteToTaskTaskRequest
    extends RawPostRequest<InviteToTaskParams, String> {
  @override
  Future<http.Response> call(InviteToTaskParams params, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.inviteToTask,
      body: InviteToTaskRequestModel(taskId: params.taskId.toString()).toJson(),
      token: token,
      id: params.lawyerId.toString(),
    );

    return response;
  }
}
