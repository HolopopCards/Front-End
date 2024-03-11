import 'package:flutter/material.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';
import 'package:holopop/shared/storage/create_application_storage.dart';
import 'package:lottie/lottie.dart';

class CreateStart extends StatefulWidget {
  const CreateStart({super.key});

  @override
  State<StatefulWidget> createState() => _CreateStart();
}

class _CreateStart extends State<CreateStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: CreateApplicationStorage().getAppAsync(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          }

          if (snapshot.data?.success == true) {
            // Do something if there's already an app.
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width / 9),
                    const Text("Choose Card Type", style: TextStyle(fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () { },
                    )
                  ],
                )),
              Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                    onTap: () {
                      CreateApplicationStorage()
                        .startApplicationAsync("greeting")
                        .then((_) => Navigator.pushNamed(context, "/create/qr"));
                    },
                    child: Lottie.asset("assets/lotties/Greeting Card.json"),
                  )),
              Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                    onTap: () {
                      CreateApplicationStorage()
                        .startApplicationAsync("invitation")
                        .then((_) => Navigator.pushNamed(context, "/create/qr"));
                    },
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
                // Flexible(
                //   child: FractionallySizedBox(
                //     widthFactor: 0.5,
                //     child: TextButton(
                //       onPressed: () => Navigator.push(context, 
                //         MaterialPageRoute(builder: (ctx) => const HowItWorks())),
                //       child: const Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Icon(Icons.play_circle_outline),
                //           Text("  See how it works"),
                //         ]
                // ))))
        ]);
    }), 
    bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.create));
  }
}