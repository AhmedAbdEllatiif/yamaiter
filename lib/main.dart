import 'dart:async';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yamaiter/base/base_material_app.dart';

import 'common/screen_utils/screen_util.dart';

import 'di/git_it_instance.dart';
import 'firebase_options.dart';
import 'di/rest_api_di.dart' as get_init_rest_api;
import 'di/repositories_di.dart' as get_init_repositories;
import 'di/cubit_di.dart' as get_init_cubit;
import 'di/usecases_di.dart' as get_init_usecases;
import 'di/data_source_di.dart' as get_init_datasource;
import 'di/firebase.dart' as get_init_firebase;

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background,
  // such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  /// ensureInitialized
  WidgetsFlutterBinding.ensureInitialized();

  /// set orientation
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));

  /// init getIt
  await get_init_rest_api.init();
  await get_init_repositories.init();
  await get_init_cubit.init();
  await get_init_usecases.init();
  await get_init_datasource.init();
  await get_init_firebase.init();

  /// init screen util
  ScreenUtil.init();

  /// initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// to setup firebase messaging
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  /// send fcm
  _setupFCM();

  runApp(const BaseMaterialApp());
}

/// To setup FCm
///
/// Set the background messaging handler early on, as a named top-level function
/// init flutter notification plugin
Future<void> _setupFCM() async {
  /// Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);



  if (!kIsWeb) {
    /// init default android notification channel
    channel = getItInstance<AndroidNotificationChannel>();

    /// init flutter notification plugin
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: (
            int? id, String? title, String? body, String? payload) async {});

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
       );

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
          final String? payload = notificationResponse.payload;
          if (notificationResponse.payload != null) {
            debugPrint('notification payload: $payload');
          }
        });

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );


    final bool? result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }


}
