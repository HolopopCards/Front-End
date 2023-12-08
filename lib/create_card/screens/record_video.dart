import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:lottie/lottie.dart';


class RecordVideoPage extends StatefulWidget {
  const RecordVideoPage({super.key});

  @override
  State<StatefulWidget> createState() => _RecordVideoPage();
}

class _RecordVideoPage extends State<RecordVideoPage> {
  final _pageController = PageController(initialPage: 0);
  int position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            const Text("Quick Guide"),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () { },
            )
          ],
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (x) { setState(() { position = x; });},
            children: const [
              RecordVideoPageLottieDisplay(asset: "assets/lotties/Instructions 1.json", text: "Distance yourself between 2 and 3 feet away from the camera"),
              RecordVideoPageLottieDisplay(asset: "assets/lotties/Instructions 2.json", text: "Ensure there is plenty of space around you within the camera frame"),
              RecordVideoPageLottieDisplay(asset: "assets/lotties/Instructions 3.json", text: "Ensure there is enough contrast between you and the background behind you"),
              RecordVideoPageLottieDisplay(asset: "assets/lotties/Instructions 4.json", text: "Ensure your setting is well-illuminated before recording"),
              RecordVideoPageLottieDisplay(asset: "assets/lotties/Instructions 5.json", text: "Any objects that are black in color will appear as transparent in the hologram"),
            ],
          )
        ),
        DotsIndicator(
          dotsCount: 5,
          position: position,
          decorator: const DotsDecorator(
            activeColor: HolopopColors.blue,
            color: Colors.white
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}


class RecordVideoPageLottieDisplay extends StatelessWidget {
  const RecordVideoPageLottieDisplay({
    super.key, 
    required this.asset, 
    required this.text
  });

  final String asset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Lottie.asset(asset, height: MediaQuery.of(context).size.height * 0.45),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16
            ),
          )
        )
      ]
    );
  }
}