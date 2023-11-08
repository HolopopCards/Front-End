import 'card.dart';

class CardService {
  static Future<List<HolopopCard>> getCards() {
    return Future.delayed(
      const Duration(seconds: 3), 
      () => List.generate(
        5,
        (i) => 
          HolopopCard(
            from: "TEST",
            subject: "Test",
            sent: DateTime.now())));
  }
}