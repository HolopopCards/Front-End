import 'package:awesome_notifications/awesome_notifications.dart';

class HolopopNotifications {
  bool notify(String title, String content) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        category: NotificationCategory.Social,
        channelKey: "basic_channel",
        actionType: ActionType.Default,
        title: title,
        body: content
      )
    );

    return true;
  }
}