import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/accept_terms/accept_terms_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';


class GetAcceptTermsCase extends UseCase<AcceptTermsEntity, String> {
  final RemoteRepository remoteRepository;

  GetAcceptTermsCase({required this.remoteRepository});

  @override
  Future<Either<AppError, AcceptTermsEntity>> call(String params) async =>
      await remoteRepository.getAcceptTerms(params);
}
