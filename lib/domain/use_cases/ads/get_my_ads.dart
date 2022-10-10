import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/ad_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetMyAdsCase extends UseCase<List<AdEntity>, String> {
  final RemoteRepository remoteRepository;

  GetMyAdsCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<AdEntity>>> call(String params) async =>
      await remoteRepository.getMyAdsList(params);
}
