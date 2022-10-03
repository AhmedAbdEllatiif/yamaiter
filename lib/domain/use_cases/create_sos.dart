import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/create_sos_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../data/models/success_model.dart';

class CreateSosCase extends UseCase<SuccessModel, CreateSosParams> {
  final RemoteRepository remoteRepository;

  CreateSosCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(CreateSosParams params) async =>
      await remoteRepository.createSos(params);
}
