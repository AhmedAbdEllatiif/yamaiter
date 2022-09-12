import 'package:dartz/dartz.dart';

import '../entities/app_error.dart';

/// UseCase<Type,Params>
/// * [Type] is the return type
/// * [Params] is the params you should pass to function
abstract class UseCase<Type, Params> {
  Future<Either<AppError, Type>> call(Params params);
}
