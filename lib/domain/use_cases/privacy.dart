import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../entities/app_error.dart';
import '../entities/data/side_menu_page_entity.dart';
import '../repositories/remote_repository.dart';

class GetPrivacyCase extends UseCase<SideMenuPageEntity, String> {
  final RemoteRepository remoteRepository;

  GetPrivacyCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SideMenuPageEntity>> call(
          String params) async =>
      await remoteRepository.getPrivacy(params);
}
