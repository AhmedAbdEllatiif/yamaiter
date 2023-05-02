import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';

import '../../../params/get_single_article_params.dart';
import '../../request_type.dart';

class GetSingleArticleRequest extends GetRequest<GetSingleArticleParams> {
  @override
  Future<http.Response> call(GetSingleArticleParams params) async {
    var response = await initGetRequest(
      requestType: RequestType.singleArticle,
      id: params.articleId,
      token: params.userToken,
    );
    return response;
  }
}
