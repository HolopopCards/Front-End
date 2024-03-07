import 'package:flutter/material.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';
import 'package:holopop/shared/widgets/holopop_placeholder.dart';

class CreateHowItWorks extends StatelessWidget {
  const CreateHowItWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          Flexible(
            child: FractionallySizedBox(
              heightFactor: 0.9,
              child: HolopopPlaceholder(customMessage: "How it works here"))),
        ]
      ),
    bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.create));
  }

}