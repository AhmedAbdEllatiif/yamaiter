import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/login_request_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/login_response_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class LoginCase extends UseCase<LoginResponseEntity, LoginRequestParams> {
  final RemoteRepository remoteRepository;

  LoginCase({required this.remoteRepository});

  @override
  Future<Either<AppError, LoginResponseEntity>> call(
          LoginRequestParams params) async =>
      await remoteRepository.login(params);
}
