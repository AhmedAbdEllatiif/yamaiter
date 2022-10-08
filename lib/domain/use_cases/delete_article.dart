import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/delete_article_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../data/models/success_model.dart';

class DeleteArticleCase extends UseCase<SuccessModel, DeleteArticleParams> {
  final RemoteRepository remoteRepository;

  DeleteArticleCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(DeleteArticleParams params) async =>
      await remoteRepository.deleteArticle(params);
}
