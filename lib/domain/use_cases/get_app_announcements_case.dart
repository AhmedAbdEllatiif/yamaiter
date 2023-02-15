import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/get_app_announcements.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/app_announcements_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetAppAnnouncementsCase
    extends UseCase<AppAnnouncementsEntity, GetAnnouncementsParams> {
  final RemoteRepository remoteRepository;

  GetAppAnnouncementsCase({required this.remoteRepository});

  @override
  Future<Either<AppError, AppAnnouncementsEntity>> call(
          GetAnnouncementsParams params) async =>
      await remoteRepository.getAppAnnouncements(params);
}
