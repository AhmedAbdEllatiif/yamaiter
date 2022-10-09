import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/create_ad_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../data/models/success_model.dart';

class CreateAdCase extends UseCase<SuccessModel, CreateAdParams> {
  final RemoteRepository remoteRepository;

  CreateAdCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(CreateAdParams params) async =>
      await remoteRepository.createAd(params);
}
