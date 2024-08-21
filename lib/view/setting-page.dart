import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../controllers/timer-controller.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});
  final timerCtr = Get.find<TimerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Set Session Time'),
              SizedBox(
                width: Get.width * .8,
                height: 60,
                child: SfSlider(
                  stepSize: 5,
                  min: 5.0,
                  max: 60.0,
                  value: timerCtr.start.value / 60,
                  interval: 5,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 0,
                  onChanged: (dynamic value) {
                    int minutes = double.parse(value.toString()).round();
                    timerCtr.start.value = minutes * 60;
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
