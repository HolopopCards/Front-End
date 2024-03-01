import 'package:flutter/material.dart';
import 'package:holopop/dashboard/screens/settings/terms_of_use.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';

class TermsCheckbox extends StatefulWidget {
  const TermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged, 
  });

  final bool value;
  final Function(bool?) onChanged;

  @override
  State<StatefulWidget> createState() => _TermsCheckbox();
}

class _TermsCheckbox extends State<TermsCheckbox> {
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
                text: "Terms and conditions", 
                style: const TextStyle(color: HolopopColors.blue), 
                recognizer: TapAndPanGestureRecognizer()..onTapDown = (_) { Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Scaffold(body: TermsOfUse()))) ;}
              )
            ]
          )
        )
      ],
    );
  }
}