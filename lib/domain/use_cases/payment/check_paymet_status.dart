import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/success_model.dart';
import 'package:yamaiter/data/params/payment/check_payment_status_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class CheckPaymentStatusCase
    extends UseCase<SuccessModel, CheckPaymentStatusParams> {
  final RemoteRepository remoteRepository;

  CheckPaymentStatusCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(
          CheckPaymentStatusParams params) async =>
      await remoteRepository.checkForPaymentStatus(params);
}
