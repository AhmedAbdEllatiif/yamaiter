import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';

class ChatRoomArguments {
  final AuthorizedUserEntity authorizedUserEntity;
  final int chatRoomId;
  final String chatChannel;

  ChatRoomArguments({
    required this.authorizedUserEntity,
    required this.chatRoomId,
    required this.chatChannel,
  });
}
