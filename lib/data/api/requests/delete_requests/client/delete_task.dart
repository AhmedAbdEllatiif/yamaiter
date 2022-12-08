import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/delete_request.dart';

import '../../../../params/client/delete_task_params.dart';
import '../../../constants.dart';

class DeleteTaskClientRequest extends DeleteRequest<DeleteTaskClientParams> {
  @override
  Future<http.Response> call(DeleteTaskClientParams params) async {
    var response = await initDeleteRequest(
      requestType: RequestType.deleteTaskClient,
      token: params.userToken,
      id: params.id.toString(),
    );
    return response;
  }
}
