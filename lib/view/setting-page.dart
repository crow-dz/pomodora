import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pomodora/utils/functions.dart';
import 'package:pomodora/utils/globals.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../controllers/timer-controller.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});
  final timerCtr = Get.find<TimerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Set Session Time'),
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
                    int workSeconds = (double.parse(value.toString()).round() * 60);
                    timerCtr.start.value = workSeconds;
                    timerCtr.total.value = workSeconds;
                    timerCtr.labelTimer.value =
                        formattedTime(timeInSecond: workSeconds);
                  },
                ),
              ),
             const SizedBox(height: 20,),
               const Text('Relax Session Time'),
              SizedBox(
                width: Get.width * .8,
                height: 60,
                child: SfSlider(
                  stepSize: 5,
                  min: 5.0,
                  max: 30.0,
                  value: timerCtr.startRelax.value / 60,
                  interval: 5,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 0,
                  onChanged: (dynamic value) {
                    int seconds = (double.parse(value.toString()).round() * 60);
                    timerCtr.startRelax.value = seconds;
                    timerCtr.totalRelax.value = seconds;
                    timerCtr.labelTimer.value =
                        formattedTime(timeInSecond: seconds);
                  },
                ),
              ),
                const SizedBox(height: 20,),
               const Text("Number of Session's"),
              SizedBox(
                width: Get.width * .8,
                height: 60,
                child: SfSlider(
                  stepSize:1,
                  min: 1.0,
                  max: 4.0,
                  value: timerCtr.session.length,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 0,
                  onChanged: (dynamic value) {
                    
                  },
                  onChangeEnd: (value) {
                    timerCtr.sessionNumber(value.round());
                
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
