import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:yamaiter/common/enum/pusher_error.dart';
import 'package:yamaiter/data/data_source/pusher_data_source.dart';
import 'package:yamaiter/data/models/chats/message_item_model.dart';

part 'pusher_state.dart';

class PusherCubit extends Cubit<PusherState> {
  PusherCubit() : super(PusherInitial());

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  void initPusher({required String chatChannel}) async {
    // loading
    emit(LoadingPusherConnection());

    // init pusher data source
    PusherDataSource(
      chatChannel: chatChannel,
      onMessageReceived: onMessageReceived,
      onPusherErrorReceived: onPusherErrorReceived,
    );
  }

  /*
  *
  * On message received
  *
  * */
  void onMessageReceived(types.Message message) {
    emit(PusherNewMessageReceived(message));
  }

  /*
  *
  * On [PusherError] received
  *
  * */
  void onPusherErrorReceived(PusherError pusherError) {
    switch (pusherError) {
      case PusherError.errorWhileReceivingMessageFromEvent:
        emit(ErrorWhileReceivingNewMessageState());
        break;
      case PusherError.onSubscriptionError:
        emit(PusherSubscriptionErrorOccurred());
        break;
      case PusherError.initializationError:
        // TODO: Handle this case.
        break;
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Pusher >> Connection: $currentState");
  }

  void onPusherError(String message, int? code, dynamic e) {
    log("Pusher >> onError: $message code: $code exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("Pusher >> nSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("Pusher >> Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("Pusher >> onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("Pusher >> onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("Pusher >> onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("Pusher >> onMemberRemoved: $channelName user: $member");
  }
}
