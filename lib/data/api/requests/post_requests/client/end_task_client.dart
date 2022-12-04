import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/models/tasks/end_task_request_model.dart';

import '../../../../params/client/end_task_params_client.dart';

class EndTaskClientRequest extends RawPostRequest<EndTaskParamsClient, String> {
  @override
  Future<http.Response> call(EndTaskParamsClient params, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.endTaskClient,
      body: EndTaskRequestModel(rating: params.rating).toJson(),
      token: token,
      id: params.taskId.toString(),
    );

    return response;
  }
}
