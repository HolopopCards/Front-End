import 'package:flutter/material.dart';
import 'package:holopop/dashboard/screens/sent_and_received_card_pages.dart';
import 'package:holopop/dashboard/services/card_service.dart';
import 'package:holopop/scan/scan_service.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:logging/logging.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<StatefulWidget> createState() => _Scan();
}

class _Scan extends State<Scan> {
  final _mobileScannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back);

  @override
  void initState() {
    super.initState();
    Logger('scan').fine("SCAN INIT");
    _mobileScannerController.stop() // Don't even ask why this works.
      .then((_) => _mobileScannerController.start());
  }

  @override
  void dispose() {
    Logger('scan').fine("SCAN DISPOSE");
    _mobileScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height / 9, 0, 0),
          child: const Text("Scan QR Code",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28))),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 30),
          child: Text("Find the QR code on the pull tab of the card.",
            style: TextStyle(
              color: HolopopColors.lightGrey))),
        Flexible(
          child: FractionallySizedBox(
            heightFactor: 0.60,
            child: MobileScanner(
              controller: _mobileScannerController,
              onDetect: (capture) {
                final barcodes = capture.barcodes;
                Logger('scan').info("Detected ${barcodes.length} barcodes.");
                for (final barcode in barcodes) {
                  final rawValue = barcode.rawValue;
                  Logger('scan').info("Bar code: $rawValue");
                  if (rawValue != null && rawValue.startsWith("https://holopop.cards/card/")) {
                    final serialNumber = rawValue.split("/").last;
                    Logger('scan').info("Serial number found: $serialNumber");

                    ScanService.scanCard(serialNumber)
                      .then((serialNumberRes) {
                        Logger('scan').info("Scanned card: ${serialNumberRes.success}");
                        if (serialNumberRes.success == true) {
                          CardService.getCard(serialNumberRes.value!)
                            .then((cardRes) {
                              if (cardRes.success == true) {
                                Navigator.pushNamed(context, "/received-card", arguments: SentAndReceivedCardArgs(card: cardRes.value!));
                              }
                            });
                        }
                      });
                  }
                }
              },
            ))),
      ]),
    bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.holopop));
  }
}