import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/client/get_my_consultations_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/client/consultation_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetMyConsultationsCase
    extends UseCase<List<ConsultationEntity>, GetMyConsultationParams> {
  final RemoteRepository remoteRepository;

  GetMyConsultationsCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<ConsultationEntity>>> call(
          GetMyConsultationParams params) async =>
      await remoteRepository.getMyConsultations(params);
}
