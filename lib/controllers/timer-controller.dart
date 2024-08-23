import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';

import 'package:pomodora/utils/functions.dart';

import '../utils/globals.dart';

class TimerController extends GetxController {
  Timer? objectTimer;
  RxInt start = 300.obs;
  RxInt total = 300.obs;
  RxInt startRelax = 300.obs;
  RxInt totalRelax = 300.obs;
  RxDouble percent = 1.0.obs;
  RxString labelTimer = '00:30'.obs;
  RxBool isRunning = false.obs;
  RxInt currentSession = 0.obs;
 RxMap session = {
    0: sessionStats,
  }.obs;

  void startTimer(int work, int relax) {
    isRunning.value = true;
    if (objectTimer != null) {
      objectTimer!.cancel();
    }
    start.value = work;
    startRelax.value = relax;

    const oneSec = Duration(seconds: 1);
    if (currentSession.value <= session.length) {
      objectTimer = Timer.periodic(
        oneSec,
        (Timer timer) {
          if (!session[currentSession.value]['isDoneWork']) {
            if (start < 1) {
              timer.cancel();
              // Set Work to Done
              session[currentSession.value]['isDoneWork'] = true;
              labelTimer.value = formattedTime(timeInSecond: relax);
              percent.value = 1.0;
              isRunning.value = false;
            } else {
              start.value = start.value - 1;
              progress();
            }
          } else {
            if (startRelax < 1) {
              timer.cancel();
              // Set Relax to Done
              session[currentSession.value]['isDoneRelax'] = true;
              isRunning.value = false;
              // fresh start also starRelax
              startRelax.value = 15;
              start.value = 30;
              currentSession.value += 1;
            } else {
              startRelax.value = startRelax.value - 1;
              progress();
            }
          }
        },
      );
    }

    log('Session ID :${currentSession.value}');
  }

  void stopTimer() {
    isRunning.value = false;
    objectTimer!.cancel();
  }

  void timerEnd() {
    stopTimer();
  }

  void progress() {
    int seconds = !session[currentSession.value]['isDoneWork']
        ? start.value
        : startRelax.value;
    int totals = !session[currentSession.value]['isDoneWork']
        ? total.value
        : totalRelax.value;
    log(start.value.toString());
    labelTimer.value = formattedTime(timeInSecond: seconds);
    percent.value = (seconds / totals);
  }

void sessionNumber(int sessionLength) {

  int currentLength = session.length;

  if (sessionLength > currentLength) {
    // Add Session
    for (var id = currentLength; id < sessionLength; id++) {
      session[id] = sessionStats;
    }
  } else if (sessionLength < currentLength) {
    // Remove Session
    session.removeWhere((key, value) => key >= sessionLength);
  }

  log(session.toString());
}

  @override
  void dispose() {
    objectTimer?.cancel();
    super.dispose();
  }
}
