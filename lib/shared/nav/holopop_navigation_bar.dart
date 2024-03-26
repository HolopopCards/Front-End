import 'package:flutter/material.dart';
import 'package:holopop/create_card/screens/create_media_type.dart';
import 'package:holopop/create_card/screens/create_start.dart';
import 'package:holopop/dashboard/screens/dashboard_page.dart';
import 'package:holopop/scan/scan.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:holopop/shared/widgets/holopop_placeholder.dart';

enum NavBarItem { dashboard, holopop, create, shop }

class NavBarMap {
  final NavBarItem item;
  final int index;
  final Widget widget;
  NavBarMap(this.item, this.index, this.widget);
}

class HolopopNavigationBar {
  static final List<NavBarMap> itemList = [
    NavBarMap(NavBarItem.dashboard, 0, const DashboardPage()),
    NavBarMap(NavBarItem.holopop, 1, const Scan()),
    NavBarMap(NavBarItem.create, 2, const CreateStart()), // DEV
    NavBarMap(NavBarItem.shop, 3, const HolopopPlaceholder()),
  ];

  static BottomNavigationBar getNavBar(BuildContext context, NavBarItem currentItem) =>
    BottomNavigationBar(
      currentIndex: itemList.firstWhere((i) => i.item == currentItem).index,
      onTap: (i) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => itemList[i].widget)),
      selectedItemColor: HolopopColors.blue,
      unselectedItemColor: HolopopColors.lightGrey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(label: 'Dashboard', icon: Icon(Icons.wallet)),
        BottomNavigationBarItem(label: 'Holopop', icon: Icon(Icons.qr_code_scanner)),
        BottomNavigationBarItem(label: 'Create Card', icon: Icon(Icons.add_circle_outlined)),
        // BottomNavigationBarItem(label: 'Shop', icon: Icon(Icons.shop)),
      ]
  );
}