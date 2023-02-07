import 'dart:convert';

import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/data/models/user_lawyer_model.dart';

import '../../../domain/entities/chat/received_chat_list_entity.dart';
import 'message_item_model.dart';

List<ReceivedChatListModel> receivedChatListResponseModelFromJson(
    String jsonStr) {
  final List<ReceivedChatListModel> receivedChats = [];

  // decode json
  final receivedJson = jsonDecode(jsonStr);

  if (receivedJson == null) {
    throw Exception("ReceivedChatListModel >> "
        "receivedChatListResponseModelFromJson >> received json is null");
  }

  if (receivedJson["chats"] == null) {
    throw Exception(
        "ReceivedChatListModel >> receivedChatListResponseModelFromJson >> Chats is null not found in the received json"
            " while parsing ReceivedChatListModel");
  }

  // return empty list if chats list is empty
  if ((receivedJson["chats"] as List).isEmpty) return receivedChats;

  // loop on chats
  for (var chatItem in receivedJson["chats"]) {
    receivedChats.add(ReceivedChatListModel.fromJson(chatItem));
  }

  return receivedChats;
}

class ReceivedChatListModel extends ReceivedChatListEntity {
  final String currentChatChannel;
  final int currentChatId;
  final UserLawyerModel currentLawyerModel;
  final MessageItemModel lastMessage;

  const ReceivedChatListModel({
    required this.currentChatChannel,
    required this.currentChatId,
    required this.currentLawyerModel,
    required this.lastMessage,
  }) : super(
    chatId: currentChatId,
    chatChannel: currentChatChannel,
    lawyerEntity: currentLawyerModel,
    lastMessageToShow: lastMessage,
  );

  factory ReceivedChatListModel.fromJson(dynamic json) {
    /// throw exception if the data is null from the json
    if (json["chat"] == null) {
      throw Exception(
          "ReceivedChatListModel >> fromJson >> Chat is null not found in the received json"
              " while parsing ReceivedChatListModel");
    }

    if (json["chat"]["content"] == null) {
      throw Exception(
          "ReceivedChatListModel >> fromJson >> Content is null not found in chat object"
              " while parsing ReceivedChatListModel");
    }

    if (json["chat"]["user"] == null) {
      throw Exception(
          "ReceivedChatListModel >> fromJson >> User is null not found in chat object"
              " while parsing ReceivedChatListModel");
    }


    /*
    *
    * if json["chat"]["content"] is an empty array that means
    * there is not messages between these two users
    * */
    final dynamic contentJson;
    if ((json["chat"]["content"]) is List) {
      contentJson =
      (json["chat"]["content"] as List).isEmpty ? {} : json["chat"]["content"];
    }else {
      contentJson = json["chat"]["content"];
    }


    return ReceivedChatListModel(
      //==> chatChannel
      currentChatChannel: json["chat"]["chat_channel"] ?? AppUtils.undefined,

      //==> chat id
      currentChatId: json["chat"]["chat_id"] ?? -1,

      //==> other user on the chat
      currentLawyerModel: json["chat"]["user"] != null
          ? UserLawyerModel.fromJson(json["chat"]["user"])
          : UserLawyerModel.empty(),

      lastMessage: MessageItemModel.fromJson(contentJson),
    );
  }
}
