import 'package:word_generator/word_generator.dart';
import 'dart:math';
import 'card.dart';


class CardService {
  static Future<List<HolopopCard>> getCards() {
    return Future.delayed(
      const Duration(seconds: 1), 
      () => List.generate(
        10,
        (i) => 
          HolopopCard(
            from: WordGenerator().randomNoun(),
            subject: WordGenerator().randomSentence(),
            sent: DateTime.now(),
            fromMe: Random().nextBool(),
            occasion: "Happy Birthday",
            body: WordGenerator().randomSentence(30))));
  }
}