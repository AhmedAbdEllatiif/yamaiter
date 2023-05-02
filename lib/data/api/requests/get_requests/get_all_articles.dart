import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';
import 'package:yamaiter/data/params/all_articles_params.dart';

import '../../request_type.dart';
import '../../api_constants.dart';

class GetAllArticlesRequest extends GetRequest<GetArticlesParams> {
  @override
  Future<http.Response> call(GetArticlesParams params) async {
    var response = await initGetRequest(
        requestType: RequestType.allArticles,
        token: params.userToken,
        queryParams: {
          ApiParamsConstant.offset: params.offset.toString(),
        });
    return response;
  }
}
