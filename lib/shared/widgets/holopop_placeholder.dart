import 'package:flutter/material.dart';

class HolopopPlaceholder extends StatelessWidget {
  const HolopopPlaceholder({super.key, this.customMessage});

  final String? customMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: Placeholder()),
        Text(customMessage ?? "Coming soon!")
      ]
    );
  }
}