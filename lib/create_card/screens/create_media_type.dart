import 'package:flutter/material.dart';
import 'package:holopop/create_card/screens/create_marketplace_audio.dart';
import 'package:holopop/create_card/screens/create_record_video.dart';
import 'package:holopop/create_card/screens/create_upload.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';
import 'package:holopop/shared/widgets/standard_header.dart';
import 'package:lottie/lottie.dart';

class CreateMediaType extends StatelessWidget {
  const CreateMediaType({super.key});

  @override
  Widget build(BuildContext context) => 
    Scaffold(
      body: Column(
      children: [
        StandardHeader(
          headerTitle: "Media Type",
          onBackPressed: () { Navigator.pushNamed(context, "Dashboard"); },  
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView(
              children: [
                MediaTypeLottie(lottieUrl: "assets/lotties/Record Video.json", path: CreateRecordVideo.route()),
                MediaTypeLottie(lottieUrl: "assets/lotties/Upload Video.json", path: CreateUpload.route()),
                MediaTypeLottie(lottieUrl: "assets/lotties/Browse Marketplace.json", path: CreateMarketplaceAudio.route()),
              ]
            )
          )
        )
      ]
    ),
    bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.create));
}


class MediaTypeLottie extends StatelessWidget {
  const MediaTypeLottie({
    super.key,
    required this.lottieUrl,
    required this.path
  });

  final String lottieUrl;
  final String path;

  @override
  Widget build(BuildContext context) => 
    Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () { Navigator.pushNamed(context, path); },
        child: Lottie.asset(lottieUrl),
      )
    );

}