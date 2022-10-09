import 'package:yamaiter/domain/entities/data/article_entity.dart';
import 'package:yamaiter/presentation/logic/cubit/update_article/update_article_cubit.dart';

class UpdateArticleArguments {
  final UpdateArticleCubit updateArticleCubit;
  final String userToken;
  final ArticleEntity articleEntity;

  UpdateArticleArguments({
    required this.articleEntity,
    required this.userToken,
    required this.updateArticleCubit,
  });
}
