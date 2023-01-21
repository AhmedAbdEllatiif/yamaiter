import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/chat/fetch_chats_lists_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/chat/received_chat_list_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class FetchChatListCase
    extends UseCase<List<ReceivedChatListEntity>, FetchChatsListParams> {
  final RemoteRepository remoteRepository;

  FetchChatListCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, List<ReceivedChatListEntity>>> call(
          FetchChatsListParams params) async =>
      await remoteRepository.fetchChatList(params);
}
