import 'package:flutter/material.dart';
import 'package:holopop/shared/banuba/banuba.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';

class CreateRecordVideo extends StatefulWidget {
  const CreateRecordVideo({super.key});

  @override
  State<StatefulWidget> createState() => _CreateRecordVideo();
}

class _CreateRecordVideo extends State<CreateRecordVideo> {
  @override
  Widget build(BuildContext context) => 
    Scaffold(
      body: const Banuba(),
      bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.create));
}
