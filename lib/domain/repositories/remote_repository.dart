import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/login_request_params.dart';
import 'package:yamaiter/domain/entities/data/login_response_entity.dart';

import '../entities/app_error.dart';

abstract class RemoteRepository {
  /// login
  Future<Either<AppError, LoginResponseEntity>> login(
      LoginRequestParams loginRequestParams);
}
