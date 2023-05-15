import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../enum/received_notification_type.dart';

class NotificationHandler {
  final BuildContext context;
  final RemoteMessage remoteMessage;
  late final String _notificationType;
  late final int _destinationId;
  late final ReceivedNotificationType _receivedNotificationType;

  NotificationHandler( this.context,{required this.remoteMessage}) {

    /// init type
    _notificationType = remoteMessage.data["type"] ?? "";

    /// init id
    _destinationId = remoteMessage.data["id"] == null
        ? -1
        : int.tryParse(remoteMessage.data["id"]) ?? -1;

    /// init receivedNotificationType as enum
    _receivedNotificationType =  receivedNotificationFromString(_notificationType);
  }


  void navigateToThePage(){
    _receivedNotificationType.openRequiredPage(context,id: _destinationId);
  }
}
