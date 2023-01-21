import 'dart:convert';

import 'message_item_model.dart';

ReceivedChatRoomResponseModel receivedChatRoomResponseModelFromJson(
    String jsonStr) {
  return ReceivedChatRoomResponseModel.fromJson(jsonDecode(jsonStr));
}

class ReceivedChatRoomResponseModel {
  final int unReadMessagesCount;
  final List<MessageItemModel> content;

  ReceivedChatRoomResponseModel(
      {required this.unReadMessagesCount, required this.content});

  factory ReceivedChatRoomResponseModel.fromJson(Map<String, dynamic> json) {
    /// throw exception if the data is null from the json
    if (json["data"] == null) {
      throw Exception("Data is null not found in the received json"
          " while parsing ReceivedDirectChatResponseModel");
    }
    return ReceivedChatRoomResponseModel(
      unReadMessagesCount: json["data"]['your unseened messages'] ?? -1,
      content: listOfChatItemsFromJson(json["data"]["content"]),
    );
  }
}
