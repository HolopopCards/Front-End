import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:holopop/dashboard/models/card.dart';
import 'package:holopop/dashboard/services/card_service.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';


class SentAndReceivedCardArgs {
  final HolopopCard card;

  SentAndReceivedCardArgs({required this.card});
}


/// Core sent pages.
class SentCardPage extends StatefulWidget {
  const SentCardPage({super.key, required this.args});

  final SentAndReceivedCardArgs args;

  @override
  State<StatefulWidget> createState() => _SentCardPage();
}

class _SentCardPage extends State<SentCardPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: 
      Column(
        children: [
          OccasionForSent(card: widget.args.card),
          Video(serialNumber: widget.args.card.serialNumber),
          DateAndSwitch(card: widget.args.card),
          CardDetails(card: widget.args.card)
        ],
      )
    );
  }
}


/// Core received pages.
class ReceivedCardPage extends StatefulWidget {
  const ReceivedCardPage({super.key, required this.args});

  final SentAndReceivedCardArgs args;

  @override
  State<StatefulWidget> createState() => _ReceivedCardPage();
}

class _ReceivedCardPage extends State<ReceivedCardPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          OccasionForReceived(card: widget.args.card),
          Video(serialNumber: widget.args.card.serialNumber),
          DateAndSwitch(card: widget.args.card),
          CardDetails(card: widget.args.card)
        ],
      )
    );
  }
}


/// Shows occasion and back button.
class OccasionForReceived extends StatelessWidget {
  const OccasionForReceived({
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

/// Shows occasion, back button, and edit button.
class OccasionForSent extends StatelessWidget {
  const OccasionForSent({super.key, required this.card});

  final HolopopCard card;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () { Navigator.pop(context); },
        ),
        Text(card.occasion),
        TextButton(
          onPressed: () { 
            Navigator.pushNamed(context, "/edit-sent-card");
          },
          child: const Text("Edit"),
        )
      ],
    );
  }
}


/// Shows video.
class Video extends StatefulWidget {
  const Video({super.key, required this.serialNumber});

  final String serialNumber;

  @override
  State<StatefulWidget> createState() => _Video();

}
class _Video extends State<Video> {
  Timer? t;
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    CardService.getVideo(widget.serialNumber)
      .then((cont) {
        _controller = cont;
        return _controller!.initialize();
      })
      .then((_) => setState(() { }));
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) => 
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _controller?.value.isInitialized == true
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    t?.cancel();
                    t = Timer(const Duration(seconds: 2), () => setState(() => t = null));
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 4.0/3.0,
                      child: Chewie(
                        controller: ChewieController(
                          videoPlayerController: _controller!,
                          allowFullScreen: true))),
                    Center(
                      child: AnimatedOpacity(
                        opacity: t != null ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              _controller!.value.isPlaying ? _controller!.pause() : _controller!.play(); 
                            });
                          },
                          child: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow))))
                  ],
                )
            )
            : SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: const FractionallySizedBox(
                heightFactor: 0.3,
                widthFactor: 0.3,
                child: CircularProgressIndicator()
              ),
            )
        ),
      ],
    );
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
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Created: $formattedSent"),
          // Switch(
          //   value: originalSwitch,
          //   activeColor: HolopopColors.blue,
          //   onChanged: (value) { setState(() { originalSwitch = value; }); },
          // )
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
  bool favorited = false;

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
                        icon: favorited ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
                        onPressed: () { setState(() { favorited = !favorited; }); }
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