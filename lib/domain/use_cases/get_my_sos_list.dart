import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetMySosListCase extends UseCase<List<SosEntity>, String> {
  final RemoteRepository remoteRepository;

  GetMySosListCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<SosEntity>>> call(String params) async =>
      await remoteRepository.getMySosList(params);
}
