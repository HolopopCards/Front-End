import 'package:holopop/dashboard/models/notification.dart';
import 'package:word_generator/word_generator.dart';

class NotificationService {
  static Future<List<HolopopNotification>> getNotifications() {
    return Future.delayed(
      const Duration(seconds: 2),
      () => List.generate(
        3,
        (_) =>
          HolopopNotification(
            from: WordGenerator().randomNames(2).join(' '),
            date: DateTime.now(),
            message: WordGenerator().randomSentence(7)
          )
      )
    );
  }
}