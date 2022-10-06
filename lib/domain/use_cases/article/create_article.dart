import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/create_article_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/models/success_model.dart';

class CreateArticleCase extends UseCase<SuccessModel, CreateArticleParams> {
  final RemoteRepository remoteRepository;

  CreateArticleCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(
          CreateArticleParams params) async =>
      await remoteRepository.createArticle(params);
}
