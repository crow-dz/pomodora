import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pomodora/controllers/timer-controller.dart';

import '../utils/theme.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});
  final timerCtr = Get.find<TimerController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularPercentIndicator(
            radius: 120.0,
            lineWidth: 25.0,
            animation: false,
            percent: timerCtr.percent.value,
            center: Text(
              timerCtr.labelTimer.value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
            ),
            footer: const Row(
              children: [],
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: const Color(0xff7650f6),
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: secondaryColor,
                    border:
                        Border.all(color: const Color(0xff7650f6), width: 1.5)
                    /*  borderRadius: BorderRadius.circular(16) */
                    ),
                child: const Center(
                    child: Text(
                  'Skip',
                  style: TextStyle(
                      color: Color(0xff7650f6), fontWeight: FontWeight.bold),
                )),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  if (timerCtr.isRunning.isFalse) {
                    timerCtr.startTimer(timerCtr.start.value);
                  } else {
                    timerCtr.stopTimer();
                  }
                },
                child: Container(
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xff7650f6), width: 2)),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff7650f6),
                      /*  borderRadius: BorderRadius.circular(16) */
                    ),
                    child: Icon(
                      timerCtr.isRunning.isTrue
                          ? Ionicons.pause
                          : Ionicons.play,
                      color: const Color(0xfffffffe),
                      size: 35,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  timerCtr.percent.value = 0;
                  timerCtr.start.value = 0;
                  timerCtr.objectTimer!.cancel();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: secondaryColor,
                      border:
                          Border.all(color: const Color(0xff7650f6), width: 1.5)
                      /*  borderRadius: BorderRadius.circular(16) */
                      ),
                  child: const Center(
                    child: Icon(
                      Entypo.controller_stop,
                      color: Color(0xff7650f6),
                    ),
                  ),
                ),
              ),
            ],
          ),
          /* const SizedBox(height: 20,),
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          InkWell(
                onTap: () {
                  timerCtr.percent.value = 0;
                  timerCtr.start.value = 0;
                  timerCtr.objectTimer!.cancel();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:const Color(0xff7650f6),
                      border:
                          Border.all(color: const Color(0xff7650f6), width: 1.5)
                      /*  borderRadius: BorderRadius.circular(16) */
                      ),
                  child: const Center(
                    child: Icon(
                   FontAwesome.coffee,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
         ],) */
        ],
      );
    }));
  }
}
