import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/create_tax_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/models/success_model.dart';

class CreateTaxCase extends UseCase<SuccessModel, CreateTaxParams> {
  final RemoteRepository remoteRepository;

  CreateTaxCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(CreateTaxParams params) async =>
      await remoteRepository.createTax(params);
}
