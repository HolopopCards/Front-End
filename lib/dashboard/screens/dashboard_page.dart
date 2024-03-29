import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:holopop/dashboard/models/card.dart';
import 'package:holopop/dashboard/screens/see_all_page.dart';
import 'package:holopop/dashboard/services/card_service.dart';
import 'package:holopop/dashboard/widgets/display_card.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:holopop/dashboard/widgets/title_and_settings.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardPage();

  static String route() => "/dashboard";
}

class _DashboardPage extends State<DashboardPage> {
  final Future<List<HolopopCard>> cards = CardService.getCards();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const TitleAndSettings(),
            const Search(),
            Expanded(
              child: DashboardBody(cards: cards,)
            )
          ]
        )),
      bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.dashboard));
  }
}


/// Search bar for cards.
class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) => 
    SearchBar(
      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 10)),
      onTap: () { },
      onChanged: (_) { },
      leading: const Icon(Icons.search),
      hintText: 'Search cards',
    );
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
            return DisplayWithCards(cards: data);
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
          onPressed: () => Navigator.pushNamed(context, "/create"),
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
class DisplayWithCards extends StatelessWidget {
  const DisplayWithCards({super.key,required this.cards});

  final List<HolopopCard> cards;

  @override
  Widget build(BuildContext context) {
    final receivedCards = cards.where((c) => c.fromMe == false).toList();
    receivedCards.sort((a,b) => b.sent.compareTo(a.sent));
    final sentCards = cards.where((c) => c.fromMe == true).toList();
    sentCards.sort((a,b) => b.sent.compareTo(a.sent));
    return Column(
      children: [
        CarouselHeader(
          headerLine: "Received cards",
          cards: receivedCards,
          areReceivedCards: true),
        Carousel(cards: receivedCards, areReceivedCards: true,),
        CarouselHeader(
          headerLine: "Sent cards",
          cards: sentCards,
          areReceivedCards: false),
        Carousel(cards: sentCards, areReceivedCards: false,)
      ],
    );
  }
}


/// Header over the carousel.
class CarouselHeader extends StatelessWidget {
  const CarouselHeader({
    super.key,
    required this.headerLine,
    required this.cards,
    required this.areReceivedCards
  });

  final String headerLine;
  final List<HolopopCard> cards;
  final bool areReceivedCards;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.mail_outlined),
            const SizedBox(width: 5),
            Text(
              headerLine,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(
              context, 
              "/all-received-cards", 
              arguments: SeeAllCardsArgs(
                cards: cards,
                headerLine: headerLine,
                areReceivedCards: areReceivedCards
              )
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor: MaterialStateProperty.all(HolopopColors.lightGrey),
            textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 11,)),
          ),
          child: const Text("See All"),
        )
      ]
    );
  }
}


/// Carousel for the images.
class Carousel extends StatelessWidget {
  const Carousel({super.key, required this.cards, required this.areReceivedCards});

  final List<HolopopCard> cards;
  final bool areReceivedCards;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height / 3,
        padEnds: false,
        autoPlay: false,
        viewportFraction: 0.5,
        enableInfiniteScroll: false,
      ),
      items: cards.map((card) {
        return Builder(
          builder: (context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: DisplayCard(
                args: DisplayCardsArgs(
                  card: card, 
                  areReceivedCards: areReceivedCards
                )
              ),
            );
          }
        );
      }).toList()
    );
  }
}