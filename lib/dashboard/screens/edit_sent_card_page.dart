import 'package:flutter/material.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';


/// Core edit page.
class EditSentCardPage extends StatefulWidget {
  const EditSentCardPage({super.key});

  @override
  State<StatefulWidget> createState() => _EditSentCardPage();
}

class _EditSentCardPage extends State<EditSentCardPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Header(),
        Body()
      ],
    );
  }
}


/// Header
class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () { Navigator.pop(context); },
        ),
        const Text("Edit Card"),
        TextButton(
          onPressed: () { }, //TODO: DO
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.transparent),
            foregroundColor: MaterialStatePropertyAll(HolopopColors.blue)
          ),
          child: const Text("Save"),
        )
      ],
    );
  }
}


/// Body
class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        EditTextField(
          title: "Card name",
          subtitle: "Give your card a name. The recipient will see this.",
          placeholder: "Happy Birthday, John",
        ),
        EditTextField(
          title: "Recipient",
          subtitle: "Name of person who will receive the card.",
          placeholder: "John",
        ),
        EditDropdownField(
          title: "Occasion",
          subtitle: "What's the occasion for the card.",
        ),
        EditTextField(
          title: "Personalized message",
          subtitle: "Include a personalized message with your card.",
          placeholder: "Wishing you a happy birthday!",
        )
      ],
    );
  }
}


class EditTextField extends StatelessWidget {
  const EditTextField({
    super.key,
    required this.title,
    required this.subtitle,
    required this.placeholder
  });

  final String title;
  final String subtitle;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(title)
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10), 
                child: Text(subtitle)
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: 
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: placeholder,
                      hintStyle: const TextStyle(
                        color: HolopopColors.grey,
                        fontWeight: FontWeight.w300
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      iconColor: HolopopColors.darkgrey
                    ),
                  ),
                )
              )
            ],
          )
        ]
      ),
    );
  }
}


class EditDropdownField extends StatelessWidget {
  const EditDropdownField({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(title)
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10), 
                child: Text(subtitle)
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: 
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    value: "Birthday",
                    onChanged: (value) { },
                    items: const [
                      DropdownMenuItem(value: "Birthday", child: Text("Birthday"))
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      iconColor: HolopopColors.darkgrey,
                    ),
                    style: const TextStyle(color: HolopopColors.lightgrey)
                  ),
                ),
              )
            ],
          )
        ]
      ),
    );
  }
}