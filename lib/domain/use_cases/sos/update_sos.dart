import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/models/success_model.dart';
import '../../../data/params/update_sos_params.dart';

class UpdateSosCase extends UseCase<SuccessModel, UpdateSosParams> {
  final RemoteRepository remoteRepository;

  UpdateSosCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(UpdateSosParams params) async =>
      await remoteRepository.updateSos(params);
}
