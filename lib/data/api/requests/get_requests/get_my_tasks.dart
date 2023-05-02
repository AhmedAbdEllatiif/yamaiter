import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';

import '../../../params/get_my_tasks_params.dart';
import '../../api_constants.dart';
import '../../request_type.dart';

class GetMyTasksRequest extends GetRequest<GetMyTasksParams> {
  @override
  Future<http.Response> call(GetMyTasksParams params) async {
    var response = await initGetRequest(
        requestType: RequestType.myTasks,
        token: params.userToken,
        queryParams: {
          ApiParamsConstant.status: params.status.toString(),
          ApiParamsConstant.offset: params.offset.toString(),
        });
    return response;
  }
}
