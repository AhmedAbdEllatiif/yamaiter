import '../../models/chats/send_chat_message_model_request.dart';

class SendChatMessageParams {
  final String userToken;
  final int chatId;
  late final SendChatModelRequest sendChatModelRequest;

  SendChatMessageParams({
    required this.userToken,
    required this.chatId,
    required final String content,
    required final String filePath,
  }) {
    sendChatModelRequest = SendChatModelRequest(
      content: content,
      filePath: filePath,
    );
  }
}
