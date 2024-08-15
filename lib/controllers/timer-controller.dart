import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  Timer? timer;
  RxInt start = 30.obs;
  RxInt total = 30.obs;
  RxDouble percent = 0.0.obs;

  void startTimer() {
    Duration oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timerEnd();
        } else {
          progress();
        }
      },
    );
  }

  timerEnd() {
    timer!.cancel();
  }

  progress() {
    start.value--;
    percent.value = (start.value / total.value);
  }
}
