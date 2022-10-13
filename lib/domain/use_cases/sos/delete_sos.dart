import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/delete_sos_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/models/success_model.dart';

class DeleteSosCase extends UseCase<SuccessModel, DeleteSosParams> {
  final RemoteRepository remoteRepository;

  DeleteSosCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(DeleteSosParams params) async =>
      await remoteRepository.deleteSos(params);
}
