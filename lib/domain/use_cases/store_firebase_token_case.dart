import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/success_model.dart';
import 'package:yamaiter/data/params/store_fb_token.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class StoreFirebaseTokenCase
    extends UseCase<SuccessModel, StoreFirebaseTokenParams> {
  final RemoteRepository remoteRepository;

  StoreFirebaseTokenCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(
          StoreFirebaseTokenParams params) async =>
      await remoteRepository.storeFirebaseToken(params);
}
