import 'package:yamaiter/presentation/logic/cubit/update_article/update_article_cubit.dart';

class UpdateArticleArguments {
  final UpdateArticleCubit updateArticleCubit;
  final String userToken;
  final int articleId;

  UpdateArticleArguments({
    required this.articleId,
    required this.userToken,
    required this.updateArticleCubit,
  });
}
