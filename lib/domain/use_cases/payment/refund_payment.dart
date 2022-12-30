import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/success_model.dart';
import 'package:yamaiter/data/params/payment/refund_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class RefundPaymentCase extends UseCase<SuccessModel, RefundParams> {
  final RemoteRepository remoteRepository;

  RefundPaymentCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(RefundParams params) async =>
      await remoteRepository.refundPayment(params);
}
