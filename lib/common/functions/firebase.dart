import 'package:firebase_messaging/firebase_messaging.dart';

Future<String> getFirebaseToken() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  return fcmToken ?? "";
}

void handleTopicsSubscription(Map<String, bool> listeners) async {
  listeners.forEach((key, value) async {
    if (value) {
      await FirebaseMessaging.instance.subscribeToTopic(key);
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic(key);
    }
  });
}
