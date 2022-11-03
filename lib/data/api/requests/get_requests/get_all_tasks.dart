import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';

import '../../../params/get_all_task_params.dart';
import '../../constants.dart';

class GetAllTasksRequest extends GetRequest<GetAllTasksParams> {
  @override
  Future<http.Response> call(GetAllTasksParams params) async {
    var response = await initGetRequest(
        requestType: RequestType.allTasks,
        token: params.userToken,
        queryParams: {
          ApiParamsConstant.offset: params.offset.toString(),
        });
    return response;
  }
}
