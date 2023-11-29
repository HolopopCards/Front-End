import 'package:flutter/material.dart';
import 'package:holopop/dashboard/models/card.dart';
import 'package:holopop/dashboard/screens/sent_and_received_card_pages.dart';


class DisplayCardsArgs {
  final HolopopCard card;
  final bool areReceivedCards;

  DisplayCardsArgs({required this.card, required this.areReceivedCards});
}


class DisplayCard extends StatelessWidget {
  const DisplayCard({
    super.key, 
    required this.args, 
  });

  final DisplayCardsArgs args;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              args.areReceivedCards ? "/received-card" : "/sent-card",
              arguments: SentAndReceivedCardArgs(card: args.card)
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/confetti.jpg'),
              )
            )
          )
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.topLeft, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "From: ${args.card.from}",
                  style: const TextStyle(fontSize: 10)),
                Text(
                  args.card.subject, 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
              ]
            )
          )
        )
      ],
    );
  }
}