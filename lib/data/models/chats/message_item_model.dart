import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/data/models/user_lawyer_model.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

/// to return a list of  [MessageItemModel]
List<MessageItemModel> listOfChatItemsFromJson(dynamic listOfContent) {
  final List<MessageItemModel> chatsItems = [];

  if (listOfContent == null) {
    throw Exception(
        "MessageItemModel >> listOfChatItemsFromJson >>The content list is null");
  }

  if ((listOfContent as List).isEmpty) return chatsItems;

  for (var chatItem in listOfContent) {
    chatsItems.add(MessageItemModel.fromJson(chatItem));
  }

  return chatsItems;
}

class MessageItemModel {
  final int messageId;
  final int chatId;
  final String chatItemMessage;
  final String file;
  final String senderUserType;
  final int senderId;
  final int seen;
  final String sender;
  final String updateAtReadable;
  final bool isYou;
  final UserLawyerModel senderUser;
  final String messageCreatedAt;
  final String messageUpdatedAt;

  MessageItemModel({
    required this.messageId,
    required this.chatId,
    required this.chatItemMessage,
    required this.file,
    required this.senderUserType,
    required this.senderId,
    required this.seen,
    required this.messageCreatedAt,
    required this.messageUpdatedAt,
    required this.sender,
    required this.updateAtReadable,
    required this.isYou,
    required this.senderUser,
  });

  factory MessageItemModel.fromJson(Map<String, dynamic> json) {
    return MessageItemModel(
      messageId: json['id'] ?? -1,
      chatId: json['chat_id'] ?? -1,
      chatItemMessage: json['message'] ?? AppUtils.undefined,
      file: json['file'] ?? AppUtils.undefined,
      senderUserType: json['senderable_type'] ?? AppUtils.undefined,
      senderId: json['senderable_id'] ?? -1,
      seen: json['seen'] ?? -1,
      sender: json['sender'] ?? AppUtils.undefined,
      updateAtReadable: json['update_at_readable'] ?? AppUtils.undefined,
      isYou: json['is_you'] ?? false,
      senderUser: json['senderable'] != null
          ? UserLawyerModel.fromJsonSenderable(json['senderable'])
          : UserLawyerModel.empty(),
      messageCreatedAt: json['created_at'] ?? AppUtils.undefined,
      messageUpdatedAt: json['updated_at'] ?? AppUtils.undefined,
    );
  }

  factory MessageItemModel.fromReceivedPusherEventJson(dynamic json) {
    //==> check tha data is null
    final dataJson = json["data"];
    if (dataJson == null) {
      throw Exception("MessageItemModel >> fromReceivedPusherEventJson >> "
          "Error: data object not found inside the json");
    }

    //==> check sender_data is null
    final senderData = json["sender_data"];
    if (senderData == null) {
      throw Exception("MessageItemModel >> fromReceivedPusherEventJson >> "
          "Error: sender_data object not found inside the json");
    }

    return MessageItemModel(
      messageId: dataJson['id'] ?? -1,
      chatId: dataJson['chat_id'] ?? -1,
      chatItemMessage: dataJson['message'] ?? AppUtils.undefined,
      file: json['file'] ?? AppUtils.undefined,
      senderUserType: json['senderable_type'] ?? AppUtils.undefined,
      seen: json['seen'] ?? -1,
      updateAtReadable: json['update_at_readable'] ?? AppUtils.undefined,
      isYou: json['is_you'] ?? false,

      // the sender user id
      senderId: dataJson['senderable_id'] ?? -1,

      // the sender a string "lawyer" or "client"
      sender: json['sender'] ?? AppUtils.undefined,

      // senderUser
      senderUser: senderData["user"] != null
          ? UserLawyerModel.fromJson(senderData["user"])
          : UserLawyerModel.empty(),

      // date
      messageCreatedAt: json['created_at'] ?? AppUtils.undefined,
      messageUpdatedAt: json['updated_at'] ?? AppUtils.undefined,
    );
  }

  Map<String, dynamic> toChatMessageJson() {
    final convertedCreatedAt = DateTime.tryParse(messageCreatedAt);
    final createdAt = convertedCreatedAt != null
        ? convertedCreatedAt.millisecondsSinceEpoch
        : 0;
    return {
      "author": {
        "firstName": senderUser.firstName,
        "id": senderId.toString(),
        "lastName": senderUser.lastName,
        "imageUrl": senderUser.profileImage
      },
      "createdAt": createdAt,
      "id": messageId.toString(),
      "status": types.Status.seen.name,
      "text": chatItemMessage,
      "type": "text"
    };
  }

  factory MessageItemModel.empty() {
    return MessageItemModel(
      messageId: -1,
      chatId: -1,
      chatItemMessage: AppUtils.undefined,
      file: AppUtils.undefined,
      senderUserType: AppUtils.undefined,
      senderId: -1,
      seen: -1,
      messageCreatedAt: AppUtils.undefined,
      messageUpdatedAt: AppUtils.undefined,
      sender: AppUtils.undefined,
      updateAtReadable: AppUtils.undefined,
      isYou: false,
      senderUser: UserLawyerModel.empty(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
