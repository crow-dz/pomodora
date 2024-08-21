import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';

import 'package:pomodora/utils/functions.dart';

class TimerController extends GetxController {
  Timer? objectTimer;
  RxInt start = 300.obs;
  RxInt total = 300.obs;
  RxInt startRelax = 300.obs;
  RxInt totalRelax = 300.obs;
  RxDouble percent = 1.0.obs;
  RxString labelTimer = '00:30'.obs;
  RxBool isRunning = false.obs;
  RxInt currentSession =0.obs;
  Map session = {
   0: {
      'isDoneWork': false,
      'isDoneRelax': false,
    },
    1: {
      'isDoneWork': false,
      'isDoneRelax': false,
    },
  };

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

  @override
  void dispose() {
    objectTimer?.cancel();
    super.dispose();
  }
}

/* import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:pomodora/utils/functions.dart';

class TimerController extends GetxController {
  Timer? objectTimer;
  RxInt start = 60.obs;
  RxInt total = 60.obs;
  RxInt startRelax = 30.obs;
  RxInt totalRelax = 30.obs;
  RxDouble percent = 1.0.obs;
  RxString labelTimer = '01:00'.obs;
  RxBool isRunning = false.obs;
  RxBool isWorkSession = true.obs; // Track if it's a work or relax session
  Map session = {
    1: {
      'isDoneWork': false,
      'isDoneRelax': false,
    },
  };

  void startTimer(int timerDuration) {
    isRunning.value = true;
    if (objectTimer != null) {
      objectTimer!.cancel();
    }

    if (isWorkSession.value) {
      start.value = timerDuration;
    } else {
      start.value = startRelax.value;
    }

    const oneSec = Duration(seconds: 1);
    objectTimer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (isWorkSession.value && !session[1]['isDoneWork']) {
          if (start.value < 1) {
            session[1]['isDoneWork'] = true;
            timer.cancel();
            stopTimer();
          } else {
            start.value = start.value - 1;
            progress();
          }
        } else if (!isWorkSession.value && !session[1]['isDoneRelax']) {
          if (start.value < 1) {
            session[1]['isDoneRelax'] = true;
            timer.cancel();
            timerEnd();
          } else {
            start.value = start.value - 1;
            progress();
          }
        }
      },
    );
  }

  void startRelaxSession() {
    isWorkSession.value = false;
    startTimer(startRelax.value);
  }

  void stopTimer() {
    isRunning.value = false;
    objectTimer?.cancel();
  }

  void timerEnd() {
    stopTimer();
  }

  void progress() {
    log(start.value.toString());
    labelTimer.value = formattedTime(timeInSecond: start.value);
    percent.value = (isWorkSession.value ? start.value / total.value : start.value / totalRelax.value);
  }

  @override
  void dispose() {
    objectTimer?.cancel();
    super.dispose();
  }
}
 */
