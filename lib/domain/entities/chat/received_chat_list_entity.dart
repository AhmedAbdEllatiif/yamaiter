import 'package:equatable/equatable.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';

import '../../../data/models/chats/message_item_model.dart';
import '../../../data/models/user_lawyer_model.dart';

class ReceivedChatListEntity extends Equatable {
  final String chatChannel;
  final int chatId;
  final LawyerEntity lawyerEntity;

  late final MessageItemModel lastMessageToShow;

  ReceivedChatListEntity({
    required this.chatChannel,
    required this.chatId,
    required this.lawyerEntity,
    required final List<MessageItemModel> messages,
  }) {
    // init last message to show
    if (messages.isNotEmpty) {
      final lastMessage = messages.last;
      lastMessageToShow = lastMessage;
    } else {
      lastMessageToShow = MessageItemModel.empty();
    }
  }

  @override
  List<Object?> get props => [
        chatId,
        chatChannel,
        lawyerEntity,
        lastMessageToShow,
      ];
}
