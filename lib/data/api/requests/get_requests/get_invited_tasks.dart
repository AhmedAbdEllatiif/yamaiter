import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';
import 'package:yamaiter/data/params/get_invited_task_params.dart';
import '../../constants.dart';

class GetInvitedTasksRequest extends GetRequest<GetInvitedTasksParams> {
  @override
  Future<http.Response> call(GetInvitedTasksParams params) async {
    var response = await initGetRequest(
        requestType: RequestType.invitedTask,
        token: params.userToken,
        queryParams: {
          ApiParamsConstant.offset: params.offset.toString(),
        });
    return response;
  }
}
