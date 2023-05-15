import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../enum/received_notification_type.dart';

class NotificationHandler {
  final BuildContext context;
  final RemoteMessage remoteMessage;
  late final String _notificationType;
  late final int _destinationId;
  late final ReceivedNotificationType _receivedNotificationType;
  late final String _chatChannel;

  NotificationHandler(this.context, {required this.remoteMessage}) {
    /// init type
    _notificationType = remoteMessage.data["type"] ?? "";

    /// init id
    _destinationId = remoteMessage.data["id"] == null
        ? -1
        : int.tryParse(remoteMessage.data["id"]) ?? -1;

    /// init _chatChannel
    _chatChannel = remoteMessage.data["chat_channel"] ?? "";

    /// init receivedNotificationType as enum
    _receivedNotificationType =
        receivedNotificationFromString(_notificationType);
  }

  void navigateToThePage() {
    _receivedNotificationType.openRequiredPage(
      context,
      id: _destinationId,
      chatChannel: _chatChannel,
    );
  }
}
