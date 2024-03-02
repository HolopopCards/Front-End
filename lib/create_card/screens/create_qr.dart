import 'package:flutter/material.dart';

import 'package:holopop/shared/storage/create_application.dart';
import 'package:holopop/shared/storage/create_application_storage.dart';
import 'package:logging/logging.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


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
        Flexible(
          child: FractionallySizedBox(
            heightFactor: 0.9,
            child: MobileScanner(
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates,
                facing: CameraFacing.back,
              ),
              onDetect: (capture) {
                final barcodes = capture.barcodes;
                Logger('create:qr').info("Detected ${barcodes.length} barcodes.");
                for (final barcode in barcodes) {
                  final rawValue = barcode.rawValue;
                  Logger('create:qr').info("Bar code: $rawValue");
                  if (rawValue != null && rawValue.startsWith("https://holopop.cards/card/")) {
                    final serialNumber = rawValue.split("/").last;
                    Logger('create:qr').info("Serial number found: $serialNumber");

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
                          app.cards[existingCardIndex].barcode = rawValue;
                        } else {
                          app.cards.add(
                            CreateApplicationCard(
                              order: app.cards.length + 1,
                              serialNumber: serialNumber,
                              barcode: rawValue));
                        }
                      })
                      .then((_) => CreateApplicationStorage().getAppAsync())
                      .then((_) => Navigator.pushNamed(context, "/create/details"));
                  }
                }
              },
            ))),
      ]
    );
  }
}