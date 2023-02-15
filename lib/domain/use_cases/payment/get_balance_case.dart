import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/payment/get_balance_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/balance_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetBalanceCase extends UseCase<BalanceEntity, GetBalanceParams> {
  final RemoteRepository remoteRepository;

  GetBalanceCase({required this.remoteRepository});

  @override
  Future<Either<AppError, BalanceEntity>> call(GetBalanceParams params) async =>
      await remoteRepository.getBalance(params);
}
