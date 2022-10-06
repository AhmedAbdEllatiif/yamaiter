import 'package:yamaiter/data/models/article/create_article_request_model.dart';

class CreateArticleParams {
  final CreateArticleRequestModel requestModel;
  final String token;

  CreateArticleParams({
    required this.requestModel,
    required this.token,
  });
}
