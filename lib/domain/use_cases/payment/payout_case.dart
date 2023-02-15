import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/success_model.dart';
import 'package:yamaiter/data/params/payment/pay_out_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class PayoutCase extends UseCase<SuccessModel, PayoutParams> {
  final RemoteRepository remoteRepository;

  PayoutCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(PayoutParams params) async =>
      await remoteRepository.payout(params);
}
