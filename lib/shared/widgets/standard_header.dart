import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
            icon: SvgPicture.asset(
            "assets/icons/arrow back - white.svg",
            height: 25,
            width: 25,
          ),
          onPressed: () { onBackPressed == null ? Navigator.pop(context) : onBackPressed!(); },
        ),
        Text(headerTitle),
        const SizedBox()
      ],
    );
}