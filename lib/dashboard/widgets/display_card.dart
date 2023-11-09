import 'package:flutter/material.dart';
import 'package:holopop/dashboard/card.dart';


class DisplayCard extends StatelessWidget {
  const DisplayCard({super.key, required this.card});

  final HolopopCard card;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/confetti.jpg'),
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
                  "From: ${card.from}",
                  style: const TextStyle(fontSize: 10)),
                Text(
                  card.subject, 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
              ]
            )
          )
        )
      ],
    );
  }
}