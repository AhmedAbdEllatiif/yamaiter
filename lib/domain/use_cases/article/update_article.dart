import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/create_article_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/models/success_model.dart';

class UpdateArticleCase
    extends UseCase<SuccessModel, CreateOrUpdateArticleParams> {
  final RemoteRepository remoteRepository;

  UpdateArticleCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(
          CreateOrUpdateArticleParams params) async =>
      await remoteRepository.updateArticle(params);
}
