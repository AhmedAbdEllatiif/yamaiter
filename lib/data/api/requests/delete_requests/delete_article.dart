import 'package:http/src/response.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/delete_request.dart';
import 'package:yamaiter/data/params/delete_article_params.dart';

import '../../constants.dart';

class DeleteArticleRequest extends DeleteRequest<DeleteArticleParams> {
  @override
  Future<Response> call(DeleteArticleParams params) async {
    var response = await initDeleteRequest(
        requestType: RequestType.deleteArticle,
        token: params.userToken,
        id: params.id.toString());
    return response;
  }
}
