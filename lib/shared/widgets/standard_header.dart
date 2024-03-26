import 'package:flutter/material.dart';

class StandardHeader extends StatelessWidget {
  const StandardHeader({
    super.key,
    required this.headerTitle,
    this.onBackPressed
  });

  final String headerTitle;
  final Function? onBackPressed;

  @override
  Widget build(BuildContext context) => 
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () { onBackPressed == null ? Navigator.pop(context) : onBackPressed!(); },
        ),
        Text(headerTitle),
        SizedBox(width: MediaQuery.of(context).size.width * 0.075)
      ],
    );
}