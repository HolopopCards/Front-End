import 'package:flutter/material.dart';

class StandardHeader extends StatelessWidget {
  const StandardHeader({super.key, required this.headerTitle});

  final String headerTitle;

  @override
  Widget build(BuildContext context) => 
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () { Navigator.pop(context); },
        ),
        Text(headerTitle),
        const SizedBox()
      ],
    );
}