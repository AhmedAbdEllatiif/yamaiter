import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/success_model.dart';
import 'package:yamaiter/data/params/forget_password_params.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../entities/app_error.dart';
import '../repositories/remote_repository.dart';

class ForgetPasswordCase extends UseCase<SuccessModel, ForgetPasswordParams> {
  final RemoteRepository remoteRepository;

  ForgetPasswordCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(
          ForgetPasswordParams params) async =>
      await remoteRepository.forgetPassword(params);
}
