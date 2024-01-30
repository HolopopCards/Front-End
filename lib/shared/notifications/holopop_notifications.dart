import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:logging/logging.dart';

class HolopopNotifications {
  bool notify(String title, String content) {
    Logger('Notifications').info("Displaying notification: $title/$content");

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        category: NotificationCategory.Social,
        channelKey: "basic",
        actionType: ActionType.Default,
        title: title,
        body: content
      )
    );

    return true;
  }
}