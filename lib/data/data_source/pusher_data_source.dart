import 'dart:convert';
import 'dart:developer';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../common/enum/pusher_error.dart';
import '../models/chats/message_item_model.dart';

class PusherDataSource {
  final String chatChannel;
  final Function(types.Message) onMessageReceived;
  final Function(PusherError) onPusherErrorReceived;

  PusherDataSource({
    required this.chatChannel,
    required this.onMessageReceived,
    required this.onPusherErrorReceived,
  }) {
    _initPusher(chatChannel: chatChannel);
  }

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  /*
  *
  *
  * init pusher
  *
  *
  * */
  void _initPusher({required String chatChannel}) async {
    try {
      await pusher.init(
        apiKey: "6685ce4103fe9d0960f7",
        cluster: "eu",
        onConnectionStateChange: onConnectionStateChange,
        onError: onPusherError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        // authEndpoint: "<Your Authendpoint Url>",
        // onAuthorizer: onAuthorizer
      );
      await pusher.subscribe(channelName: chatChannel);
      await pusher.connect();
    } catch (e) {
      onPusherErrorReceived(PusherError.initializationError);
      log("PusherDataSource >> initPusher >> ERROR: >>  $e");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("PusherDataSource >> Connection: $currentState");
  }

  void onPusherError(String message, int? code, dynamic e) {
    log("Pusher >> onError: $message code: $code exception: $e");
  }

  /*
  *
  *
  * onEvent received
  *
  *
  * */
  void onEvent(PusherEvent event) {
    log("Event >> $event");

    if (event.eventName == "pusher:subscription_succeeded") return;

    try {
      // init MessageModelItem form received event.data
      final messageModelItem = MessageItemModel.fromReceivedPusherEventJson(
        jsonDecode(event.data),
      );

      // convert messageModelItem to types.Message json
      final jsonMessage = messageModelItem.toChatMessageJson();

      // init types.Message from jsonMessage
      final types.Message message = types.Message.fromJson(jsonMessage);

      // on message received
      onMessageReceived(message);
      log("Message >> $message");
    } catch (e) {
      onPusherErrorReceived(
        PusherError.errorWhileReceivingMessageFromEvent,
      );
      log("Error $e");
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("PusherDataSource >> nSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("PusherDataSource >> Me: $me");
  }

  /*
  * 
  * 
  * onSubscriptionError
  * 
  * 
  * */
  void onSubscriptionError(String message, dynamic e) {
    onPusherErrorReceived(PusherError.onSubscriptionError);
    log("PusherDataSource >> onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("PusherDataSource >> onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("PusherDataSource >> onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("PusherDataSource >> onMemberRemoved: $channelName user: $member");
  }
}
