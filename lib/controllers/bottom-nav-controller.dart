import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pomodora/utils/theme.dart';
import 'package:pomodora/view/home-page.dart';
import 'package:pomodora/view/setting-page.dart';

import '../view/stats-page.dart';

class BottomNavController extends GetxController {
  PersistentTabController controller =
      PersistentTabController(initialIndex: 1);
List<Widget> screens() {
  return [    StatsPage(),    HomePage(),    SettingPage(),  ];
}

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon:const Icon(Ionicons.ios_stats_chart),
        title: ("Home"),
        iconSize: 20,
        activeColorPrimary: mainColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon:const Icon(MaterialCommunityIcons.timer),
        title: ("Search"),
             iconSize: 25,
        activeColorPrimary: mainColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon:const Icon(Ionicons.md_settings_sharp),
        title: ("Profile"),
             iconSize: 25,
        activeColorPrimary: mainColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
