import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';

import '../../../params/my_single_task_params.dart';
import '../../request_type.dart';

class GetMySingleTaskRequest extends GetRequest<GetSingleTaskParams> {
  @override
  Future<http.Response> call(GetSingleTaskParams params) async {
    var response = await initGetRequest(
      requestType: RequestType.mySingleTask,
      token: params.userToken,
      id: params.taskId.toString(),
    );
    return response;
  }
}
