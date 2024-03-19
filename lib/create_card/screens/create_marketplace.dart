import 'package:flutter/material.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:logging/logging.dart';

class CreateMarketplace extends StatelessWidget {
  const CreateMarketplace({super.key});

  @override
  Widget build(BuildContext context) => Text("");
    // Scaffold(
    //   body: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           IconButton(
    //             icon: const Icon(Icons.chevron_left),
    //             onPressed: () => Navigator.pop(context)),
    //           const Text("Browse Marketplace"),
    //           SizedBox(width: MediaQuery.of(context).size.width * 0.1)
    //         ]),
    //       FutureBuilder(
    //         future: ,
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState != ConnectionState.done) {
    //             return const CircularProgressIndicator();
    //           }

    //           if (snapshot.hasData) {
    //             return Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 20),
    //               child: DropdownButtonFormField(
    //                 style: const TextStyle(
    //                   color: HolopopColors.lightGrey),
    //                 decoration: const InputDecoration(
    //                   contentPadding: EdgeInsets.all(10)),
    //                 hint: const Text("Select occasion"),
    //                 onChanged: (value) { },
    //                 items: const [
    //                   DropdownMenuItem(value: null, child: Text("Select occasion")),
    //                 ]));
    //           }
              
    //           Logger('create:marketplace').severe("Error getting marketplace videos: ${snapshot.error}");
    //           return Text('Error: ${snapshot.error}');
    //         },
    //       )
    //     ]
    //   ),
    //   bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.create)
    // );
}