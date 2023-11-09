import 'card.dart';

class CardService {
  static Future<List<HolopopCard>> getCards() {
    print("HERE WE GO!");
    return Future.delayed(
      const Duration(seconds: 1), 
      () => List.generate(
        5,
        (i) => 
          HolopopCard(
            from: "TEST",
            subject: "Test",
            sent: DateTime.now(),
            fromMe: false)));
  }
}