import 'package:flutter/material.dart';
import 'package:holopop/shared/widgets/holopop_placeholder.dart';

class CreateHowItWorks extends StatelessWidget {
  const CreateHowItWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Flexible(
          child: FractionallySizedBox(
            heightFactor: 0.9,
            child: HolopopPlaceholder(customMessage: "How it works here"))),
      ]
    );
  }

}