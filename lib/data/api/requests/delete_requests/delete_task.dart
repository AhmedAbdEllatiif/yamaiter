import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/delete_request.dart';

import '../../../params/delete_task_params.dart';
import '../../request_type.dart';

class DeleteTaskRequest extends DeleteRequest<DeleteTaskParams> {
  @override
  Future<http.Response> call(DeleteTaskParams params) async {
    var response = await initDeleteRequest(
      requestType: RequestType.deleteTask,
      token: params.userToken,
      id: params.id.toString(),
    );
    return response;
  }
}
