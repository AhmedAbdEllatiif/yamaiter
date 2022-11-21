import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/delete_request.dart';
import 'package:yamaiter/data/params/decline_task_params.dart';

import '../../constants.dart';

class DeclineTaskRequest extends DeleteRequest<DeclineTaskParams> {
  @override
  Future<http.Response> call(DeclineTaskParams params) async {
    var response = await initDeleteRequest(
        requestType: RequestType.declineTask,
        token: params.userToken,
        id: params.taskId.toString());
    return response;
  }
}
