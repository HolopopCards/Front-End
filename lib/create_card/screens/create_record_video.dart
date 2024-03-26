import 'package:flutter/material.dart';
import 'package:holopop/shared/banuba/banuba.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';

class CreateRecordVideo extends StatelessWidget {
  const CreateRecordVideo({super.key});

  static String route() => "/create/record";

  @override
  Widget build(BuildContext context) => 
    Scaffold(
      body: const Banuba(mode: VideoEditorMode.record),
      bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.create));
}
