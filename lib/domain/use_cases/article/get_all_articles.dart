import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/all_articles_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/article_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetAllArticlesCase
    extends UseCase<List<ArticleEntity>, GetArticlesParams> {
  final RemoteRepository remoteRepository;

  GetAllArticlesCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<ArticleEntity>>> call(
          GetArticlesParams params) async =>
      await remoteRepository.getAllArticlesList(params);
}
