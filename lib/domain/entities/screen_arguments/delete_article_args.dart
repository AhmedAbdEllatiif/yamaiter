import 'package:yamaiter/presentation/logic/cubit/delete_article/delete_article_cubit.dart';

class DeleteArticleArguments {
  final int articleId;
  final String userToken;
  final DeleteArticleCubit deleteArticleCubit;

  DeleteArticleArguments({
    required this.articleId,
    required this.userToken,
    required this.deleteArticleCubit,
  });
}
