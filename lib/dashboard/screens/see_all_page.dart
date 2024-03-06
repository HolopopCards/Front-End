import 'package:flutter/material.dart';
import 'package:holopop/dashboard/models/card.dart';
import 'package:holopop/dashboard/screens/sent_and_received_card_pages.dart';
import 'package:holopop/dashboard/widgets/display_card.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';


class SeeAllCardsArgs {
  SeeAllCardsArgs({
    required this.cards, 
    required this.headerLine, 
    required this.areReceivedCards
  });

  final List<HolopopCard> cards;
  final String headerLine;
  final bool areReceivedCards;
}


class SeeAllCardsPage extends StatelessWidget {
  const SeeAllCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SeeAllCardsArgs;
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
              Text(args.headerLine)
            ],
          ),
          Expanded(child: GridView.count(
            shrinkWrap: true,
            childAspectRatio: aspect,
            controller: ScrollController(keepScrollOffset: false),
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            children: [
              for (var card in args.cards)
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      args.areReceivedCards ? "/received-card" : "/sent-card",
                      arguments: SentAndReceivedCardArgs(card: card)
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DisplayCard(args: DisplayCardsArgs(card: card, areReceivedCards: args.areReceivedCards)),
                  )
                )
            ]
          ))
        ],
      ),
    bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.dashboard));
  }
}