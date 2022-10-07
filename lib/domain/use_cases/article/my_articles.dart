import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/article_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetMyArticlesCase extends UseCase<List<ArticleEntity>, String> {
  final RemoteRepository remoteRepository;

  GetMyArticlesCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<ArticleEntity>>> call(
      String params) async =>
      await remoteRepository.getMyArticles(params);
}
