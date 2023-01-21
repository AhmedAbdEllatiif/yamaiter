import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/success_model.dart';
import 'package:yamaiter/data/params/send_chat_message.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class SendChatMessageCase extends UseCase<SuccessModel, SendChatMessageParams> {
  final RemoteRepository remoteRepository;

  SendChatMessageCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, SuccessModel>> call(
          SendChatMessageParams params) async =>
      await remoteRepository.sendChatMessage(params);
}
