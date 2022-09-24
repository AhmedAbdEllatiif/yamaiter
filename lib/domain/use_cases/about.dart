import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/about/about_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetAboutCase extends UseCase<List<AboutEntity>, String> {
  final RemoteRepository remoteRepository;

  GetAboutCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<AboutEntity>>> call(String params) async =>
      await remoteRepository.getAboutApp(params);
}
