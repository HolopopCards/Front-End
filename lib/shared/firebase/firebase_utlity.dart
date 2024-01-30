import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:holopop/shared/notifications/holopop_notifications.dart';
import 'package:logging/logging.dart';

class FirebaseUtility {
  Future startFirebaseListening() async {
    Logger('Firebase').info('Starting Firebase listening...');
    Logger('Firebase').info('Token: ${await FirebaseMessaging.instance.getToken()}'); // TODO: Remove before prod.

    // If a message came in and the app was not already open, handle it.
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(initialMessage);
    }

    // Listen to incoming messages.
    FirebaseMessaging.onMessage.listen(handleMessage);
  }


  void handleMessage(RemoteMessage message) {
    Logger('Firebase').info('Received message: from ${message.from}, category ${message.category}, title: ${message.notification?.title}, message: ${message.notification?.body}');

    displayNotification(message);
  }


  void displayNotification(RemoteMessage message) {
    if (message.notification?.title != null && message.notification?.body != null) {
      String title = message.notification!.title!,
             body  = message.notification!.body!;

      HolopopNotifications().notify(title, body);
    }
  }


  Future<String?> getFcmToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    Logger('Firebase').info('Retrieving token: $token');

    return token;
  }
}