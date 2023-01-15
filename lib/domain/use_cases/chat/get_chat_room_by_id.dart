import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/chat_room_by_id_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class GetChatRoomByIdCase
    extends UseCase<List<types.Message>, ChatRoomByIdParams> {
  final RemoteRepository remoteRepository;

  GetChatRoomByIdCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<types.Message>>> call(
          ChatRoomByIdParams params) async =>
      await remoteRepository.getChatRoomById(params);
}
