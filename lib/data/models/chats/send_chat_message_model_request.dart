
/// body for send message request
class SendChatModelRequest {
  final String content;
  final String filePath;

  SendChatModelRequest({
    required this.content,
    required this.filePath,
  });
}
