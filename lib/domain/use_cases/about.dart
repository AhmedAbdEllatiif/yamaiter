import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../entities/data/side_menu_page_entity.dart';

class GetAboutCase extends UseCase<SideMenuPageEntity, String> {
  final RemoteRepository remoteRepository;

  GetAboutCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SideMenuPageEntity>> call(String params) async =>
      await remoteRepository.getAboutApp(params);
}
