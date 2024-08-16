import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodora/view/home-page.dart';

import 'controllers/bottom-nav-controller.dart';
import 'controllers/timer-controller.dart';
import 'view/start-page.dart';

void main() {
  Get.put(TimerController());
  Get.put(BottomNavController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyWidget(),
    );
  }
}

