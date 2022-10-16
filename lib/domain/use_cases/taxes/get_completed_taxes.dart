import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/get_taxes_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/tax_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetCompletedTaxesCase extends UseCase<List<TaxEntity>, GetTaxesParams> {
  final RemoteRepository remoteRepository;

  GetCompletedTaxesCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<TaxEntity>>> call(
      GetTaxesParams params) async =>
      await remoteRepository.getCompletedTaxes(params);
}
