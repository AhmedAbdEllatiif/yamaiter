import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';

import '../../../../params/client/get_lawyers_params.dart';

class FetchLawyersRequest extends RawPostRequest<GetLawyersParams, String> {
  @override
  Future<http.Response> call(GetLawyersParams params, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.lawyers,
      body: {},
      queryParams: {
        "rate": "desc",
        ApiParamsConstant.offset: params.offset.toString(),
      },
      token: token,
    );

    return response;
  }
}
