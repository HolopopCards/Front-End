import 'package:flutter/material.dart';
import 'package:holopop/shared/banuba/banuba.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';

class CreateMarketplaceFinal extends StatelessWidget {
  const CreateMarketplaceFinal({
    super.key,
    required this.path
  });

  final String path;

  @override
  Widget build(BuildContext context) => 
    Scaffold(
      body: Banuba(mode: VideoEditorMode.trim, path: path),
      bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.create));
}