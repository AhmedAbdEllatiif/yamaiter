import 'package:equatable/equatable.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';

import '../../../data/models/chats/message_item_model.dart';

class ReceivedChatListEntity extends Equatable {
  final String chatChannel;
  final int chatId;
  final LawyerEntity lawyerEntity;
  final MessageItemModel lastMessageToShow;

  const ReceivedChatListEntity({
    required this.chatChannel,
    required this.chatId,
    required this.lawyerEntity,
    required  this.lastMessageToShow,
  });

  @override
  List<Object?> get props => [
        chatId,
        chatChannel,
        lawyerEntity,
        lastMessageToShow,
      ];
}
