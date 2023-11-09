import 'package:flutter/material.dart';
import 'package:holopop/dashboard/card.dart';
import 'package:holopop/dashboard/widgets/display_card.dart';


class DashboardCardsPage extends StatelessWidget {
  const DashboardCardsPage({super.key, required this.cards, required this.headerLine});

  final List<HolopopCard> cards;
  final String headerLine;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final aspect = (size.height / 3) / size.width;

    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () { Navigator.pop(context); },
              ),
              Text(headerLine)
            ],
          ),
          Expanded(child: GridView.count(
            shrinkWrap: true,
            childAspectRatio: aspect,
            controller: ScrollController(keepScrollOffset: false),
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            children: [
              for (var card in cards)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DisplayCard(card: card),
                )
            ]
          ))
        ],
      )
    );
  }
}