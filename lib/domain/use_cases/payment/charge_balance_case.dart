import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/payment/charge_balance_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/charge_balance_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class ChargeBalanceCase
    extends UseCase<ChargeBalanceEntity, ChargeBalanceParams> {
  final RemoteRepository remoteRepository;

  ChargeBalanceCase({required this.remoteRepository});

  @override
  Future<Either<AppError, ChargeBalanceEntity>> call(
          ChargeBalanceParams params) async =>
      await remoteRepository.chargeBalance(params);
}
