import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/success_model.dart';
import 'package:yamaiter/data/params/delete_user_params.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../entities/app_error.dart';
import '../repositories/remote_repository.dart';

class DeleteRemoteUserCase extends UseCase<SuccessModel, DeleteUserParams> {
  final RemoteRepository remoteRepository;

  DeleteRemoteUserCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(DeleteUserParams params) async =>
      await remoteRepository.deleteUser(params);
}
