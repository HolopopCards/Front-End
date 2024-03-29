import 'package:flutter/material.dart';
import 'package:holopop/shared/banuba/banuba.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';

class CreateUpload extends StatelessWidget {
  const CreateUpload({super.key});

  static String route() => "/create/upload";

  @override
  Widget build(BuildContext context) => 
    Scaffold(
      body: const Banuba(mode: VideoEditorMode.trim),
      bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.create));
}
