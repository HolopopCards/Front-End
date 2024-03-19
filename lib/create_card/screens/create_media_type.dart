import 'package:flutter/material.dart';
import 'package:holopop/create_card/screens/create_how_to_record.dart';
import 'package:holopop/create_card/screens/create_marketplace.dart';
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
              children: const [
                MediaTypeLottie(lottieUrl: "assets/lotties/Record Video.json", widget: CreateHowToRecord()),
                MediaTypeLottie(lottieUrl: "assets/lotties/Upload Video.json", widget: CreateUpload()),
                MediaTypeLottie(lottieUrl: "assets/lotties/Browse Marketplace.json", widget: CreateMarketplace()),
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
    required this.widget
  });

  final String lottieUrl;
  final Widget widget;

  @override
  Widget build(BuildContext context) => 
    Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => widget)); },
        child: Lottie.asset(lottieUrl),
      )
    );

}