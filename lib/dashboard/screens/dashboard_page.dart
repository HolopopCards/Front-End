import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../card.dart';
import '../card_service.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<StatefulWidget> createState() => DashboardPageState();
}


class DashboardPageState extends State<DashboardPage> {
  final Future<List<HolopopCard>> cards = CardService.getCards();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const TitleAndSettings(),
          const Search(),
          Expanded(
            child: DashboardBody(cards: cards,)
          )
        ]
      )
    );
  }
}

/// Holopop title + notifications and settings.
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


/// Search bar for cards.
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


/// Rest of the page.
class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key, required this.cards });

  final Future<List<HolopopCard>> cards;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cards,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          if (data == null || data.isEmpty) {
            return const DisplayNoCards();
          } else {
            return Column(children: [DisplayCards(cards: data) ]);
          }
        } else if (snapshot.hasError) {
          return DisplayCardsError(error: snapshot.error!);
        } else {
          return const DisplayLoadingCards();
        }
      },
    );
  }
}

/// When user have no cards.
class DisplayNoCards extends StatelessWidget {
  const DisplayNoCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("No cards found"),
        TextButton(
          onPressed: () { }, //TODO: function
          child: const Text("Add a card"),
        )
      ],
    );
  }
}


/// If there was an error getting cards.
class DisplayCardsError extends StatelessWidget {
  const DisplayCardsError({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("There was an error getting cards: $error")]
    );
}


/// While user is waiting for cards.
class DisplayLoadingCards extends StatelessWidget {
  const DisplayLoadingCards({super.key});

  @override
  Widget build(BuildContext context) => const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Text("Getting cards...")]
  );
}


/// When user has cards.
class DisplayCards extends StatelessWidget {
  const DisplayCards({super.key, required this.cards});
  
  final List<HolopopCard> cards;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 3,
              padEnds: false,
              autoPlay: false,
              initialPage: 0,
              viewportFraction: 0.5,
              enableInfiniteScroll: false,
              disableCenter: true,
            ),
            items: cards.map((i) {
              return Builder(
                builder: (context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Image(image: AssetImage('assets/images/confetti.jpg')),
                  );
                }
              );
            }).toList()
          )
        ]
      )
    );
  }
}