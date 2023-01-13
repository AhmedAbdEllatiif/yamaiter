import 'package:dartz/dartz.dart';

import 'package:yamaiter/data/params/client/create_consultation_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../entities/data/pay_entity.dart';

class CreateConsultationCase
    extends UseCase<PayEntity, PayForConsultationParams> {
  final RemoteRepository remoteRepository;

  CreateConsultationCase({required this.remoteRepository});

  @override
  Future<Either<AppError, PayEntity>> call(
          PayForConsultationParams params) async =>
      await remoteRepository.createConsultation(params);
}
