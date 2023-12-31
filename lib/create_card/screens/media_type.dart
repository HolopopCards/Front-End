import 'package:flutter/material.dart';
import 'package:holopop/create_card/screens/record_video.dart';
import 'package:holopop/shared/widgets/holopop_placeholder.dart';
import 'package:holopop/shared/widgets/standard_header.dart';
import 'package:lottie/lottie.dart';

class MediaTypePage extends StatelessWidget {
  const MediaTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StandardHeader(
          headerTitle: "Media Type",
          onBackPressed: () { Navigator.pushNamed(context, "Dashboard"); },  
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView(
              children: const [
                MediaTypeLottie(lottieUrl: "assets/lotties/Record Video.json", widget: RecordVideoPage()),
                MediaTypeLottie(lottieUrl: "assets/lotties/Upload Video.json", widget: HolopopPlaceholder()),
                MediaTypeLottie(lottieUrl: "assets/lotties/Browse Marketplace.json", widget: HolopopPlaceholder()),
              ]
            )
          )
        )
      ]
    );
  }
}


class MediaTypeLottie extends StatelessWidget {
  const MediaTypeLottie({
    super.key,
    required this.lottieUrl,
    required this.widget
  });

  final String lottieUrl;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => widget)); },
        child: Lottie.asset(lottieUrl),
      )
    );
  }

}