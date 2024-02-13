import 'package:flutter/material.dart';
import 'package:holopop/shared/widgets/holopop_placeholder.dart';
import 'package:logging/logging.dart';


class CreateStart extends StatefulWidget {
  const CreateStart({super.key});

  @override
  State<StatefulWidget> createState() => _CreateStart();
}


class _CreateStart extends State<CreateStart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Flexible(
          child: FractionallySizedBox(
            heightFactor: 0.9,
            child: HolopopPlaceholder(customMessage: "QR Reader here"))),
        TextButton(
          child: const Text("This button represents scanning the QR code"),
          onPressed: () async {
            Logger('Create QR').info('QR CODE SCANNED: XXX');
            Navigator.pushNamed(context, "/create/type");
          },
        )
      ]
    );
  }
}