class ChatRoomByIdRequestModel {
  final String userToken;
  final int chatId;

  ChatRoomByIdRequestModel({
    required this.userToken,
    required this.chatId,
  });
}
