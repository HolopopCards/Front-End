import 'package:flutter/material.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:confetti/confetti.dart';

class CreateFinal extends StatefulWidget {
  const CreateFinal({super.key});

  @override
  State<StatefulWidget> createState() => _CreateFinal();
}

class _CreateFinal extends State<CreateFinal> {
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
          child: const Text("Congratulations!",
              style: TextStyle(
                color: HolopopColors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 28
              ))),
        const Padding(
          padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
          child: Text("You have successfully created your Holpop. You may now share it with the world!.",
            textAlign: TextAlign.center)),
        Padding(
          padding: const EdgeInsets.all(40),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.065,
            child: TextButton(
              child: const Text("Done"),
              onPressed: () => Navigator.pushNamed(context, "/create/media-type")))),
      ],
    );
  }
}