import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class CreateType extends StatefulWidget {
  const CreateType({super.key});

  @override
  State<StatefulWidget> createState() => _CreateType();
}


class _CreateType extends State<CreateType> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Choose Card Type", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          )),
        Padding(
          padding: const EdgeInsets.all(5),
          child: InkWell(
              onTap: () { Navigator.pushNamed(context, "/create/greeting"); },
              child: Lottie.asset("assets/lotties/Greeting Card.json"),
            )),
        Padding(
          padding: const EdgeInsets.all(5),
          child: InkWell(
              onTap: () { Navigator.pushNamed(context, "/create/invitation"); },
              child: Lottie.asset("assets/lotties/Invitation.json"),
            )),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("The stage is set. Two cards, endless expressions."),
              Text("How will you color your moment?"),
            ]
          )),
          Flexible(
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: TextButton(
                onPressed: () { },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_circle_outline),
                    Text("  See how it works"),
                  ]
          ))))
      ],
    );
  }
}