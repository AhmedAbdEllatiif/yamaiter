import 'dart:convert';

import 'chat_model.dart';

ReceivedDirectChatResponseModel receivedDirectChatResponseModelFromJson(
    String jsonStr) {
  return ReceivedDirectChatResponseModel.fromJson(jsonDecode(jsonStr));
}

class ReceivedDirectChatResponseModel {
  final int unReadMessagesCount;
  final List<MessageItemModel> content;

  ReceivedDirectChatResponseModel(
      {required this.unReadMessagesCount, required this.content});

  factory ReceivedDirectChatResponseModel.fromJson(Map<String, dynamic> json) {
    /// throw exception if the data is null from the json
    if (json["data"] == null) {
      throw Exception("Data is null not found in the received json"
          " while parsing ReceivedDirectChatResponseModel");
    }
    return ReceivedDirectChatResponseModel(
      unReadMessagesCount: json["data"]['your unseened messages'] ?? -1,
      content: listOfChatItemsFromJson(json["data"]["content"]),
    );
  }
}
