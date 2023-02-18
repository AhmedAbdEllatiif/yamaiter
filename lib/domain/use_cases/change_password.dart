import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/success_model.dart';
import 'package:yamaiter/data/params/change_password_params.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../entities/app_error.dart';
import '../repositories/remote_repository.dart';

class ChangePasswordCase extends UseCase<SuccessModel, ChangePasswordParams> {
  final RemoteRepository remoteRepository;

  ChangePasswordCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(
          ChangePasswordParams params) async =>
      await remoteRepository.changePassword(params);
}
