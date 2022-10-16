import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/tax_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/params/get_taxes_params.dart';

class GetInProgressTaxesCase extends UseCase<List<TaxEntity>, GetTaxesParams> {
  final RemoteRepository remoteRepository;

  GetInProgressTaxesCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<TaxEntity>>> call(
      GetTaxesParams params) async =>
      await remoteRepository.getInProgressTaxes(params);
}
