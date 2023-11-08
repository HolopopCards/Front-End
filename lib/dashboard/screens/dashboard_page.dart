import 'package:flutter/material.dart';

import '../card.dart';
import '../card_service.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const TitleAndSettings(),
            const Search(),
            Expanded(
              child: DashboardBody(cards: CardService.getCards())
            )
          ]
        )
      )
    );
  }
}

class TitleAndSettings extends StatelessWidget {
  const TitleAndSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("holopop"),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () { },
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () { },
            )
          ]
        )
      ]
    );
  }
}


class Search extends StatelessWidget {
  const Search({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 10)),
      onTap: () { },
      onChanged: (_) { },
      leading: const Icon(Icons.search),
      hintText: 'Search cards',
    );
  }
}


class DashboardBody extends StatelessWidget {
  const DashboardBody({
    super.key,
    required this.cards,
  });

  final Future<List<HolopopCard>> cards;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cards,
      builder: (context, snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          // We got data, check if there's cards.
          var data = snapshot.data;
          if (data == null || data.isEmpty) {
            children = [
              const Text("No cards found"),
              TextButton(
                onPressed: () { }, //TODO: function
                child: const Text("Add a card"),
              )
            ];
          } else {
            children = [const Text("OPh yeah, you got cards.")];
          }
        } else if (snapshot.hasError) {
          children = [Text("There was an error getting cards: ${snapshot.error}")];
        } else {
          children = [const Text("Getting cards...")];
        }
      
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        );
      },
    );
  }
}