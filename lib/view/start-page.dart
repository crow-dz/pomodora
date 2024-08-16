import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../controllers/bottom-nav-controller.dart';

class MyWidget extends StatelessWidget {
   MyWidget({super.key});
  final navCtr = Get.find<BottomNavController>();
@override
Widget build(BuildContext context) {
  return Scaffold(
   // body: screens(),
     bottomNavigationBar: PersistentTabView(
      decoration: NavBarDecoration(borderRadius: BorderRadius.circular(25)),
        context,
        controller: navCtr.controller,
        screens:navCtr.screens(),
        items:navCtr. navBarsItems(),
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardAppears: true,
        popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
        padding: const EdgeInsets.only(top: 8),
        margin:const EdgeInsets.all(20),
        backgroundColor: Colors.white,
        isVisible: true,
        animationSettings: const NavBarAnimationSettings(
            navBarItemAnimation: ItemAnimationSettings( // Navigation Bar's items animation properties.
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimationSettings( // Screen transition animation on change of selected tab.
                animateTabTransition: true,
                duration: Duration(milliseconds: 200),
                screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
            ),
        ),
        confineToSafeArea: true,
        navBarHeight: kBottomNavigationBarHeight,
   navBarStyle: NavBarStyle.style12, // Choose the nav bar style with this property
      ),
  );
}
}