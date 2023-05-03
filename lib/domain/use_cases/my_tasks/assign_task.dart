import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/assign_task_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/pay_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class AssignTaskCase extends UseCase<PayEntity, PayForTaskParams> {
  final RemoteRepository remoteRepository;

  AssignTaskCase({required this.remoteRepository});

  @override
  Future<Either<AppError, PayEntity>> call(PayForTaskParams params) async =>
      await remoteRepository.assignTask(params);
}
