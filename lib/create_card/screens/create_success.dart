import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';
import 'package:holopop/shared/storage/create_application_storage.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:confetti/confetti.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateSuccess extends StatefulWidget {
  const CreateSuccess({super.key});

  @override
  State<StatefulWidget> createState() => _CreateSuccess();
}

class _CreateSuccess extends State<CreateSuccess> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(days: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _confettiController.play();
    return Scaffold(
      body: FutureBuilder(
        future: CreateApplicationStorage().getAppAsync(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.success) {
            final app = snapshot.data!.value!;
            return Column(
              children: [
                ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  emissionFrequency: 0.01,
                  numberOfParticles: 25,
                  gravity: 0.05, 
                  shouldLoop: true,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ]),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
                  child: const Text("Success",
                      style: TextStyle(
                        color: HolopopColors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 28
                      ))),
                const Padding(
                  padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                  child: Text("You have successfully linked a card.\nClick the button below to continue or link another card.",
                    textAlign: TextAlign.center)),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: TextButton(
                      child: const Text("Done"),
                      onPressed: () => Navigator.pushNamed(context, "/create/media-type")))),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: HolopopColors.darkGreyBackground,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        for (var card in app.cards)
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                child: Column(
                                  children: [
                                    QrImageView(
                                      data: card.barcode,
                                      version: QrVersions.auto,
                                      backgroundColor: Colors.white,
                                      size: 65,
                                      padding: const EdgeInsets.all(4),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(card.serialNumber,
                                        style: const TextStyle(
                                          fontSize: 10))),
                                    Text(card.recipient ?? "",
                                      style: const TextStyle(
                                        fontSize: 10)),
                                  ])),
                            Positioned(
                              top: -4,
                              right: -12,
                              child: IconButton(
                                icon: SvgPicture.asset("assets/icons/circle - x - black.svg",
                                  height: 15),
                                color: Colors.black,
                                onPressed: () => Navigator.pushNamed(context, "/create/unlink", arguments: card))
                            ),
                          ]),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => Navigator.pushNamed(context, "/create/qr"),
                            color: Colors.white,
                            style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                              backgroundColor: const MaterialStatePropertyAll(HolopopColors.darkGrey)),
                          ))
                      ],
                    )))
                ],
            );
          } else {
            return const Text("Could not get app");
          }
        },
      ),
    bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.create));
  }
}