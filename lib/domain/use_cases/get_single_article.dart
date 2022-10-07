import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/get_single_article_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/article_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetSingleArticleCase extends UseCase<ArticleEntity, GetSingleArticleParams> {
  final RemoteRepository remoteRepository;

  GetSingleArticleCase({required this.remoteRepository});

  @override
  Future<Either<AppError, ArticleEntity>> call(
          GetSingleArticleParams params) async =>
      await remoteRepository.getSingleArticle(params);
}
