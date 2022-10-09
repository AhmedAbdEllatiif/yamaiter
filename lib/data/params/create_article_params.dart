import 'package:yamaiter/data/models/article/create_article_request_model.dart';

class CreateOrUpdateArticleParams {
  final CreateOrUpdateArticleRequestModel requestModel;
  final String token;
  final String articleId;

  CreateOrUpdateArticleParams( {
    required this.requestModel,
    required this.token,
    this.articleId = "",
  });
}
