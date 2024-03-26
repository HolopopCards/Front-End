import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:holopop/create_card/services/marketplace_service.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';
import 'package:holopop/shared/widgets/standard_header.dart';
import 'package:logging/logging.dart';

class CreateMarketplaceAudio extends StatelessWidget {
  const CreateMarketplaceAudio({super.key});

  static String route() => "/create/marketplace/audio";

  @override
  Widget build(BuildContext context) => 
    Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const StandardHeader(headerTitle: "Music Library"),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SearchBar(
                padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 10)),
                onTap: () { },
                onChanged: (_) { },
                leading: const Icon(Icons.search),
                hintText: 'Search music')),
            const Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Browse", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18)))),
            FutureBuilder(
              future: MarketplaceService.getAudios(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  final size = MediaQuery.of(context).size;
                  return GridView.count(
                    shrinkWrap: true,
                    childAspectRatio: (size.height * 0.66) / size.width,
                    controller: ScrollController(keepScrollOffset: false),
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    children: [
                      for (var category in snapshot.data!)
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: 
                                      InkWell(
                                        onTap: () { },
                                        child: Image(
                                          opacity: const AlwaysStoppedAnimation(0.75),
                                          height: MediaQuery.of(context).size.height * 0.15,
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          fit: BoxFit.fill,
                                          image: Image.memory(
                                            base64Decode(category.image)).image))),
                                  Column(
                                    children: [
                                      Text(category.title,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                      Text("${category.audios.length} tracks")
                                    ])
                                ]),
                            ]))
                    ]
                  );
                }

                Logger('create:marketplace:audio').severe("Error getting marketplace audios: ${snapshot.error}");
                return Text('Error: ${snapshot.error}');
              },
            )
          ]
        )),
      bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.create),
    );
}
