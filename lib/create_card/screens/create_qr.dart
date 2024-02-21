import 'dart:math';

import 'package:flutter/material.dart';
import 'package:holopop/shared/storage/create_application.dart';
import 'package:holopop/shared/storage/create_application_storage.dart';
import 'package:holopop/shared/widgets/holopop_placeholder.dart';
import 'package:logging/logging.dart';


class CreateQr extends StatefulWidget {
  const CreateQr({super.key});

  @override
  State<StatefulWidget> createState() => _CreateQr();
}


class _CreateQr extends State<CreateQr> {
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
          onPressed: () {
            final serialNumber = "${Random().nextInt(500000) + 500000}",
                  barcode = "http://sick.com/card/$serialNumber";

            Logger('Create QR').info('SERIAL NUMBER: $serialNumber | BARCODE: $barcode');
            CreateApplicationStorage()
              .updateAppAsync((app) {
                final existingCardIndex = app.cards.indexWhere((c) => c.serialNumber == serialNumber);
                // Update existing card if found, otherwise add it
                if (existingCardIndex != -1) {
                  // Rearrange order
                  for (var c in app.cards) {
                    c.order -= 1;
                  }
                  app.cards[existingCardIndex].order = app.cards.length - 1;
                  app.cards[existingCardIndex].barcode = barcode;
                } else {
                  app.cards.add(
                    CreateApplicationCard(
                      order: app.cards.length + 1,
                      serialNumber: serialNumber,
                      barcode: barcode));
                }
              })
              .then((_) => CreateApplicationStorage().getAppAsync())
              .then((_) => Navigator.pushNamed(context, "/create/details"));
          },
        )
      ]
    );
  }
}