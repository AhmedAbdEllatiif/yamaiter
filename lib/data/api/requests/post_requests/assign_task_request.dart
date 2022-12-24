import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/params/assign_task_params.dart';

class PayToAssignTaskRequest extends RawPostRequest<PayForTaskParams, String> {
  @override
  Future<http.Response> call(PayForTaskParams params, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.payToAssignTask,
      body: params.payForTaskModel.toJson(),
      token: token,
    );

    return response;
  }
}
