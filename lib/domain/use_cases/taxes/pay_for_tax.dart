import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/create_tax_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/pay_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';


class PayForTaxCase extends UseCase<PayEntity, CreateTaxParams> {
  final RemoteRepository remoteRepository;

  PayForTaxCase({required this.remoteRepository});

  @override
  Future<Either<AppError, PayEntity>> call(CreateTaxParams params) async =>
      await remoteRepository.payForTax(params);
}
