import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/success_model.dart';
import 'package:yamaiter/data/params/client/create_consultation_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class CreateConsultationCase
    extends UseCase<SuccessModel, CreateConsultationParams> {
  final RemoteRepository remoteRepository;

  CreateConsultationCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(
          CreateConsultationParams params) async =>
      await remoteRepository.createConsultation(params);
}
