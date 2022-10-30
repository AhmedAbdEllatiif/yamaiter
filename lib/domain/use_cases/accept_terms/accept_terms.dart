import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/accept_terms_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../../data/models/success_model.dart';

class AcceptTermsCase extends UseCase<SuccessModel, AcceptTermsParams> {
  final RemoteRepository remoteRepository;

  AcceptTermsCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(AcceptTermsParams params) async =>
      await remoteRepository.acceptTerms(params);
}
