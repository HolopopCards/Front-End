import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:intl/intl.dart';


// Result returned from each dialog box.
class GiftDialogResult {
  final String value;
  final GiftCard? giftCard;

  GiftDialogResult({
    required this.value, 
    this.giftCard
  });
}


class GiftCard {
  final String sku;
  final String name;
  final String assetPath;
  final String description;
  final double cost;
  final String feeSubtitle;

  GiftCard({
    required this.sku,
    required this.name, 
    required this.assetPath, 
    required this.description, 
    required this.cost, 
    required this.feeSubtitle
  });
}


// Do you want to buy a gift card?
class GiftQuestionDialog extends StatelessWidget {
  const GiftQuestionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold),
      title: const Center(
        child: Text("Add Gift Card")),
      content: FractionallySizedBox(
        heightFactor: 0.45,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: SvgPicture.asset(
                "assets/icons/gift.svg",
                height: 100,
              )),
            const Text(
              'Enhance your greeting by adding an eGift card, allowing your friend to indulge in a special treat from one of their favorite brands',
              style: TextStyle(color: Colors.black)),
          ]
        )),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context, GiftDialogResult(value: "show-cards"));
                },
                child: const Text("Yes, please"),
              )),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context, GiftDialogResult(value: "success")),
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                  foregroundColor: MaterialStatePropertyAll(Colors.black)),
                child: const Text("No thanks")),
            )
          ]
        )
      ],
    );
  }
}


class GiftCardsDialog extends StatelessWidget {
  const GiftCardsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width / 9),
          const Text("Choose Gift Card",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600)),
          IconButton(
            icon: const Icon(Icons.close),
            color: Colors.black,
            onPressed: () => Navigator.pop(context, null))
        ]
      ),
      titlePadding: const EdgeInsets.all(2.5),
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          children: [
            DropdownButtonFormField(
              decoration: const InputDecoration(
                fillColor: HolopopColors.lightGreyBackground),
              iconEnabledColor: HolopopColors.lightGrey,
              dropdownColor: HolopopColors.lightGreyBackground,
              style: const TextStyle(
                color: HolopopColors.lightGrey,
              ),
              value: "all",
              onChanged: (_) { },
              items: const [
                DropdownMenuItem(value: "all", child: Text("All brands"))
              ],
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 3/2,
              children: List.generate(5, (i) {
                final giftCard = GiftCard(
                  sku: "XXXX",
                  name: "Great Gift Card",
                  assetPath: "assets/images/placeholder-gift-card.png",
                  description: "Amazon are sold in a \$25 denomination and we are honored, just like cash, at Amazon.com. Amazon Cards cannot be redeemed for cash unless required by law. If the Amazon Card is lost, stolen, damaged, or destroyed, the value of this card will not be honored or replaced without proof of purchase and proper identification. Amazon Gift Cards have no expiration date or dormancy fees.",
                  cost: 25.00,
                  feeSubtitle: "+5% processing fee"
                );
                return IconButton(
                  icon: Image(
                    image: AssetImage(giftCard.assetPath)),
                  onPressed: () => Navigator.pop(context, GiftDialogResult(value: "show-card", giftCard: giftCard)));
              })
            )
          ],
        ),
      )
    );
  }
}


class GiftCardDialog extends StatelessWidget {
  final GiftCard giftCard;

  const GiftCardDialog({super.key, required this.giftCard});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            color: Colors.black,
            onPressed: () => Navigator.pop(context, GiftDialogResult(value: "show-cards"))),
          Text(giftCard.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600)),
          IconButton(
            icon: const Icon(Icons.close),
            color: Colors.black,
            onPressed: () { Navigator.pop(context, GiftDialogResult(value: "")); }),
        ],
      ),
      titlePadding: const EdgeInsets.all(2.5),
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.55,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 5),
              child: Image(image: AssetImage(giftCard.assetPath))),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: Text(NumberFormat.simpleCurrency().format(giftCard.cost),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24))),
            Text(giftCard.feeSubtitle,
              style: const TextStyle(
                color: HolopopColors.lightGrey,
                fontSize: 10)),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              child: Text(giftCard.description, 
                style: const TextStyle(
                  color: HolopopColors.lightGrey,
                  fontSize: 8,
                  height: 1),
                textAlign: TextAlign.justify)),
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 0.75,
                widthFactor: 0.95,
                child: TextButton(
                  child: const Text("Purchase"),
                  onPressed: () => Navigator.pop(context, GiftDialogResult(value: "purchased", giftCard: giftCard)))))
          ],
        ),
      )
    );
  }
}


class GiftCardPurchasedDialog extends StatelessWidget {
  final GiftCard giftCard;

  const GiftCardPurchasedDialog({super.key, required this.giftCard});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Success",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600)),
        ],
      ),
      titlePadding: const EdgeInsets.all(2.5),
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.55,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 5),
              child: Image(image: AssetImage(giftCard.assetPath))),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: Text(NumberFormat.simpleCurrency().format(giftCard.cost),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24))),
            Text(giftCard.feeSubtitle,
              style: const TextStyle(
                color: HolopopColors.lightGrey,
                fontSize: 10)),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              child: Text(giftCard.description, 
                style: const TextStyle(
                  color: HolopopColors.lightGrey,
                  fontSize: 8,
                  height: 1),
                textAlign: TextAlign.justify)),
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 0.75,
                widthFactor: 0.95,
                child: TextButton(
                  child: const Text("Purchase"),
                  onPressed: () => Navigator.pop(context, GiftDialogResult(value: "success")))))
          ],
        ),
      )
    );
  }
}