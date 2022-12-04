import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';
import 'package:yamaiter/data/params/client/get_single_task_params_client.dart';

import '../../../constants.dart';

class GetSingleTaskClientRequest extends GetRequest<GetSingleTaskParamsClient> {
  @override
  Future<http.Response> call(GetSingleTaskParamsClient params) async {
    var response = await initGetRequest(
      requestType: RequestType.singleTaskClient,
      token: params.userToken,
      id: params.taskId.toString(),
    );
    return response;
  }
}
