import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/client/get_consultation_details.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/client/consultation_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetConsultationDetailsCase
    extends UseCase<ConsultationEntity, GetConsultationDetailsParams> {
  final RemoteRepository remoteRepository;

  GetConsultationDetailsCase({required this.remoteRepository});

  @override
  Future<Either<AppError, ConsultationEntity>> call(
          GetConsultationDetailsParams params) async =>
      await remoteRepository.getConsultationDetails(params);
}
