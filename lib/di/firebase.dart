

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'git_it_instance.dart';

Future init() async {
  /// Default android notification channel
  getItInstance.registerFactory<AndroidNotificationChannel>(
          () => const AndroidNotificationChannel(
        'default_channel', // id
        'Default Notifications', // title
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      ));
}