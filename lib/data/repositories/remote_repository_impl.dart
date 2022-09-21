import 'package:dartz/dartz.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/data/models/auth/login/login_response.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_response.dart';
import 'package:yamaiter/data/params/login_request_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/login_response_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';

import '../data_source/remote_data_source.dart';

class RemoteRepositoryImpl extends RemoteRepository {
  final RemoteDataSource remoteDataSource;

  RemoteRepositoryImpl({
    required this.remoteDataSource,
  });

  /// Login
  @override
  Future<Either<AppError, LoginResponseEntity>> login(
      LoginRequestParams loginRequestParams) async {
    try {
      // build a LoginRequestModel
      final loginRequestModel = LoginRequestModel(
          email: loginRequestParams.email,
          password: loginRequestParams.password,
          rememberMe: "true");

      // send login request
      final result = await remoteDataSource.login(loginRequestModel);

      // success to login
      if (result is LoginResponseModel) {
        return Right(result);
      }

      // failed to login
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }
}
