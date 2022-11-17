import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/tasks/upload_task_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/models/success_model.dart';

class UploadTaskFileCase extends UseCase<SuccessModel, UploadTaskFileParams> {
  final RemoteRepository remoteRepository;

  UploadTaskFileCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(
          UploadTaskFileParams params) async =>
      await remoteRepository.uploadTaskFile(params);
}
