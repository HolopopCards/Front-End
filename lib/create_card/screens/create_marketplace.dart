import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:holopop/create_card/screens/create_marketplace_preview.dart';
import 'package:holopop/create_card/services/marketplace_service.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:logging/logging.dart';

class CreateMarketplace extends StatelessWidget {
  const CreateMarketplace({super.key});

  static String route() => "/create/marketplace";

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => Navigator.pop(context)),
                const Text("Browse Marketplace"),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1)
              ]),
            FutureBuilder(
              future: MarketplaceService.getVideos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  var occasions = snapshot.data!.map((x) => x.category)
                                                .toSet()
                                                .toList();
                  occasions.sort();

                  var groupedVideos = groupBy(snapshot.data!, (x) => x.category)
                                        .entries
                                        .sorted((a, b) => a.key.compareTo(b.key));

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButtonFormField(
                          style: const TextStyle(
                            color: HolopopColors.lightGrey),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10)),
                          hint: const Text("Select occasion"),
                          onChanged: (value) { },
                          items: [
                            const DropdownMenuItem(value: "", child: Text("Select occasion")),
                            for (var occ in occasions)
                              DropdownMenuItem(value: occ, child: Text(occ))
                          ])),
                      for (var groupedVideo in groupedVideos)
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(groupedVideo.key, style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                                  const Text("See All", style: TextStyle(
                                    color: HolopopColors.lightGrey,
                                    fontSize: 12))
                                ]),
                                CarouselSlider(
                                  options: CarouselOptions(
                                    height: MediaQuery.of(context).size.height / 4,
                                    padEnds: false,
                                    autoPlay: false,
                                    viewportFraction: 0.5,
                                    enableInfiniteScroll: false),
                                  items: groupedVideo.value.map((video) =>
                                        Builder(builder: (context) => 
                                          InkWell(
                                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateMarketplacePreview(videoId: video.id))),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              height: MediaQuery.of(context).size.height * 0.5,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: Image.memory(
                                                    base64Decode(video.image)).image,
                                                )
                                              )
                                            ))))
                                      .toList())
                            ],
                          ))
                    ]);
                }
                
                Logger('create:marketplace').severe("Error getting marketplace videos: ${snapshot.error}");
                return Text('Error: ${snapshot.error}');
              },
            )
          ]
        )),
      bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.create)
    );
}