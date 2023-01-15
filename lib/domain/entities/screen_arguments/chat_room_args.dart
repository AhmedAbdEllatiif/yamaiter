import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';

class ChatRoomArguments {
  final AuthorizedUserEntity authorizedUserEntity;
  final int chatRoomId;

  ChatRoomArguments({
    required this.authorizedUserEntity,
    required this.chatRoomId,
  });
}
