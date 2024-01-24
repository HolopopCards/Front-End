import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseProvider with ChangeNotifier {
  Future startFirebaseListening() async {
    print("Starting Firebase listening...");

    // If a message came in and the app was not already open, handle it.
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(initialMessage);
    }

    // Listen to incoming messages.
    FirebaseMessaging.onMessage.listen(handleMessage);
  }

  void handleMessage(RemoteMessage message) {
    print("Got message");
    print("from: $message.from");
    print("category: $message.category");
    print("data: $message.data");
    print("message title: ${message.notification?.title}");
    print("message: ${message.notification?.body}");
  }
}