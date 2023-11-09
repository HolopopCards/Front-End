import 'package:flutter/material.dart';
import 'package:holopop/dashboard/card.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:intl/intl.dart';


/// Core page.
class ReceivedCardPage extends StatefulWidget {
  const ReceivedCardPage({super.key, required this.card});

  final HolopopCard card;

  @override
  State<StatefulWidget> createState() => _ReceivedCardPage();
}


class _ReceivedCardPage extends State<ReceivedCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Occasion(card: widget.card),
          const Video(),
          DateAndSwitch(card: widget.card),
          CardDetails(card: widget.card)
        ],
      )
    );
  }
}


/// Shows occasion and back button.
class Occasion extends StatelessWidget {
  const Occasion({
    super.key,
    required this.card,
  });

  final HolopopCard card;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () { Navigator.pop(context); },
        ),
        Text(card.occasion)
      ],
    );
  }
}


/// Shows video.
class Video extends StatelessWidget {
  const Video({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Placeholder())
      ],
    );
  }
}


/// Shows date and video switch.
class DateAndSwitch extends StatefulWidget {
  const DateAndSwitch({super.key, required this.card});

  final HolopopCard card;

  @override
  State<StatefulWidget> createState() => _DateAndSwitch();

}

class _DateAndSwitch extends State<DateAndSwitch>  {
  bool originalSwitch = false;

  @override
  Widget build(BuildContext context) {
    final formattedSent = DateFormat('MM/dd/yyyy').format(widget.card.sent);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Created: $formattedSent"),
          Switch(
            value: originalSwitch,
            activeColor: HolopopColors.blue,
            onChanged: (value) { setState(() { originalSwitch = value; }); },
          )
        ],
      )
    );
  }
}


/// Details of the card.
class CardDetails extends StatefulWidget {
  const CardDetails({super.key, required this.card});

  final HolopopCard card;

  @override
  State<StatefulWidget> createState() => _CardDetails();
}

class _CardDetails extends State<CardDetails> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 4.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      widget.card.subject,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700
                      ),)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(widget.card.body)
                  ),
                  ButtonBar(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite_outline),
                        onPressed: () { },
                      )
                    ],
                  )
                ],
              ),
            )
          )
        )
      ],
    );
  }
}