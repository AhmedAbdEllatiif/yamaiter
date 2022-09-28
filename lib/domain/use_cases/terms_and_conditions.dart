import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/side_menu_page_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetTermsAndConditionsCase extends UseCase<List<SideMenuPageEntity>, String> {
  final RemoteRepository remoteRepository;

  GetTermsAndConditionsCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<SideMenuPageEntity>>> call(String params) async =>
      await remoteRepository.getTermsAndConditions(params);
}
