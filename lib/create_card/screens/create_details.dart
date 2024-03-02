
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holopop/create_card/screens/create_gift.dart';
import 'package:holopop/shared/storage/create_application_storage.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:logging/logging.dart';


class CreateDetailModel {
  String? name;
  String? recipient;
  String? occasion;
  String? message;

  @override
  String toString() => 
    "Create Detail Model => $name|$recipient|$occasion|$message";
}


class CreateDetails extends StatefulWidget {
  const CreateDetails({super.key});

  @override
  State<StatefulWidget> createState() => _CreateDetails();
}


class _CreateDetails extends State<CreateDetails> {
  final formKey = GlobalKey<FormState>();

  final formModel = CreateDetailModel();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => Navigator.pop(context)),
                const Text("Card Details", style: TextStyle(fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: RichText(
                  text: TextSpan(
                    text: "Save",
                    style: const TextStyle(color: HolopopColors.blue),
                    recognizer: TapAndPanGestureRecognizer()..onTapDown = (_) { 
                      Logger('Create Details').info("Create detail form completed: $formModel");
                      CreateApplicationStorage()
                        .getAppAsync()
                        .then((res) {
                          if (res.success) {
                            return CreateApplicationStorage()
                              .updateLastCardAsync((c) {
                                c.subject = formModel.name;
                                c.recipient = formModel.recipient;
                                c.occasion = formModel.occasion;
                                c.message = formModel.message;
                                return c;
                              })
                              .then((res) {
                                if (res.success) {
                                  // handleDialogResult(null); // For gift cards one day.
                                  Navigator.pushNamed(context, "/create/success");
                                }
                              });
                          }
                        });
                    }
                  )))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              name: "Card name",
              description: "Give your card a name. The recipient will see this.",   
              formField: TextFormField(
                decoration: const InputDecoration(
                  hintText: "I.e Happy Birthday, John",
                  contentPadding: EdgeInsets.all(10)
                ),
                onChanged: (value) => formModel.name = value,
              ))
            ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              name: "Recipient",
              description: "Name of person who will receive the card.",
              formField: TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10)
                ),
                onChanged: (value) => formModel.recipient = value,
              ))
            ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              name: "Occasion",
              description: "What's the occasion for the card?",
              formField: DropdownButtonFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10)
                ),
                value: "any",
                onChanged: (value) => formModel.occasion = value,
                items: const [
                  DropdownMenuItem(value: "any", child: Text("Any occasion")),
                  DropdownMenuItem(value: "birthday", child: Text("Birthday")),
                ],
              ))
            ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              name: "Personalized message",
              description: "I.e. Wishing you a happy birthday!",
              formField: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(500)
                ],
                decoration: const InputDecoration(
                  hintText: "I.e Happy Birthday, John",
                  contentPadding: EdgeInsets.all(10)),
                onChanged: (value) => formModel.message = value,
            ))),
        ],
      ));
  }

  void handleDialogResult(GiftDialogResult? result) {
    if (result?.value == "success") {
      Navigator.pushNamed(context, "/create/success");
    } else if (result?.value == "show-cards") {
      showDialog<GiftDialogResult>(context: context, builder: (ctx) => const GiftCardsDialog())
        .then((res) => handleDialogResult(res));
    } else if (result?.value == "show-card" && result?.value != null) {
      showDialog<GiftDialogResult>(context: context, builder: (ctx) => GiftCardDialog(giftCard: result!.giftCard!))
        .then((res) => handleDialogResult(res));
    } else {
      showDialog<GiftDialogResult>(context: context, builder: (ctx) => const GiftQuestionDialog())
        .then((res) => handleDialogResult(res));
    }
  }
}


class Card extends StatelessWidget {
  final String name;
  final String description;
  final Widget formField;

  const Card({
    super.key,
    required this.name,
    required this.description,
    required this.formField
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HolopopColors.darkGreyBackground,
        borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Text(
              name, 
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16))),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Text(description)),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: formField)
        ],
      ),
    );
  }
}

