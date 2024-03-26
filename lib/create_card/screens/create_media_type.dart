
import 'package:flutter/material.dart';
import 'package:holopop/create_card/screens/create_marketplace_video.dart';
import 'package:holopop/create_card/screens/create_record_video.dart';
import 'package:holopop/create_card/screens/create_upload.dart';
import 'package:holopop/dashboard/screens/dashboard_page.dart';
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
          onBackPressed: () => Navigator.pushNamed(context, DashboardPage.route()),  
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView(
              children: [
                MediaTypeLottie(lottieUrl: "assets/lotties/Record Video.json", onTap: () => Navigator.pushNamed(context, CreateRecordVideo.route())),
                MediaTypeLottie(lottieUrl: "assets/lotties/Upload Video.json", onTap: () => Navigator.pushNamed(context, CreateUpload.route())),
                MediaTypeLottie(lottieUrl: "assets/lotties/Browse Marketplace.json", onTap: () => Navigator.pushNamed(context, CreateMarketplaceVideo.route())),
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
    required this.onTap
  });

  final String lottieUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) => 
    Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
        child: Lottie.asset(lottieUrl),
      )
    );

}