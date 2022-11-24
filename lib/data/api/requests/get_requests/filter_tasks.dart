import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';
import 'package:yamaiter/data/params/filter_task_params.dart';

import '../../constants.dart';

class FilterTasksRequest extends GetRequest<FilterTasksParams> {
  @override
  Future<http.Response> call(FilterTasksParams params) async {
    var response = await initGetRequest(
        requestType: RequestType.filterTasks,
        token: params.userToken,
        queryParams: {
          ApiParamsConstant.city: params.city,
          ApiParamsConstant.orderBy: params.orderedBy,
          ApiParamsConstant.applicantsCount: params.applicantsCount.toString(),
          ApiParamsConstant.offset: params.offset.toString(),
        });
    return response;
  }
}
