import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:holopop/dashboard/screens/settings/privacy_policy.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';

class PrivacyCheckbox extends StatefulWidget {
  const PrivacyCheckbox({
    super.key,
    required this.value,
    required this.onChanged
  });

  final bool value;
  final Function(bool?) onChanged;

  @override
  State<StatefulWidget> createState() => _PrivacyCheckbox();
}


class _PrivacyCheckbox extends State<PrivacyCheckbox> {
  late bool isChecked = widget.value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (x) {
            setState(() {
              widget.onChanged(x);
              isChecked = !isChecked;
            });
          },
        ),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(text: "Agree with "),
              TextSpan(
                text: "Privacy Policy", 
                style: const TextStyle(color: HolopopColors.blue), 
                recognizer: TapAndPanGestureRecognizer()..onTapDown = (_) { Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Scaffold(body: PrivacyPolicy()))) ;}
              )
            ]
          )
        )
      ],
    );
  }
}