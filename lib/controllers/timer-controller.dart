import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';

import 'package:pomodora/utils/functions.dart';

class TimerController extends GetxController {
  Timer? objectTimer;
  RxInt start = 1500.obs;
  RxInt total = 1500.obs;
  RxDouble percent = 1.0.obs;
  RxString labelTimer = '25:00'.obs;
  RxBool isRunning = false.obs;


  void startTimer(int timerDuration) {
    isRunning.value = true;
    if (objectTimer != null) {
      objectTimer!.cancel();
    }
    start.value = timerDuration;
    const oneSec = Duration(seconds: 1);
    objectTimer = Timer.periodic(oneSec, (Timer timer) {
      if (start < 1) {
        timer.cancel();
      } else {
        start.value = start.value - 1;
        progress();
      }
    });
  }

  void stopTimer() {
    isRunning.value = false;
    objectTimer!.cancel();
  }

  void timerEnd() {
    stopTimer();
  }

  void progress() {
    log(start.value.toString());
    labelTimer.value = formattedTime(timeInSecond: start.value);
    percent.value = (start.value / total.value);
  }

  @override
  void dispose() {
    objectTimer?.cancel();
    super.dispose();
  }
}
