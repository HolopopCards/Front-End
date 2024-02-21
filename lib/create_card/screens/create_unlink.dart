import 'package:flutter/material.dart';
import 'package:holopop/shared/storage/create_application.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateUnlink extends StatefulWidget {
  const CreateUnlink({super.key, required this.card});

  final CreateApplicationCard card;

  @override
  State<StatefulWidget> createState() => _CreateUnlink();
}

class _CreateUnlink extends State<CreateUnlink> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pushNamed(context, "/create/success"),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
            child: Column(
              children: [
                QrImageView(
                  data: widget.card.barcode,
                  backgroundColor: Colors.white,
                  size: 175,
                  padding: const EdgeInsets.all(4)),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(widget.card.serialNumber,
                    style: const TextStyle(
                      fontSize: 12))),
                Text(widget.card.recipient ?? "",
                  style: const TextStyle(
                    fontSize: 10)),
                const Padding(
                  padding: EdgeInsets.fromLTRB(80, 25, 80, 40),
                  child: Text("Please confirm that you wish to unlik this QR code from your card?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: HolopopColors.lightGrey))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.075,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextButton(
                    child: const Text("Unlink"),
                    onPressed: () {
                      
                    }))
              ])),
        ]
      ),
    );
  }

}