import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/data/help_question_entity.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../entities/app_error.dart';
import '../repositories/remote_repository.dart';

class GetHelpCase extends UseCase<List<HelpQuestionEntity>, String> {
  final RemoteRepository remoteRepository;

  GetHelpCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<HelpQuestionEntity>>> call(
          String params) async =>
      await remoteRepository.getHelp(params);
}
