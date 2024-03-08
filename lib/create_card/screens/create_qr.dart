import 'package:flutter/material.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';

import 'package:holopop/shared/storage/create_application.dart';
import 'package:holopop/shared/storage/create_application_storage.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:logging/logging.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class CreateQr extends StatefulWidget {
  const CreateQr({super.key});

  @override
  State<StatefulWidget> createState() => _CreateQr();
}


class _CreateQr extends State<CreateQr> {
  final _mobileScannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    autoStart: false);

  @override
  void initState() {
    Logger('create:qr').info("QR READER INIT");
    super.initState();
    _mobileScannerController.start();
  }

  @override
  void dispose() {
    Logger('create:qr').info("QR READER DISPOSE");
    _mobileScannerController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height / 9, 0, 0),
            child: const Text("Scan QR Code",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28))),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 30),
            child: Text("Find the QR code located on the back of the card.",
              style: TextStyle(
                color: HolopopColors.lightGrey))),
          Flexible(
            child: FractionallySizedBox(
              heightFactor: 0.60,
              child: MobileScanner(
                controller: _mobileScannerController,
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
                        .then((_) => _mobileScannerController.dispose())
                        .then((_) => Navigator.pushNamed(context, "/create/details"));
                    }
                  }
                },
              ))),
        ]
    ),
    bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.create));
  }
}