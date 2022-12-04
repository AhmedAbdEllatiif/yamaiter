import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';

import '../../../../params/client/get_my_task_params_client.dart';
import '../../../constants.dart';

class GetMyTasksClientRequest extends GetRequest<GetMyTasksClientParams> {
  @override
  Future<http.Response> call(GetMyTasksClientParams params) async {
    var response = await initGetRequest(
        requestType: RequestType.myTasksClient,
        token: params.userToken,
        queryParams: {
          ApiParamsConstant.status: params.status.toString(),
          ApiParamsConstant.offset: params.offset.toString(),
        });
    return response;
  }
}
