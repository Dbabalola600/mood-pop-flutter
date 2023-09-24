import 'dart:async';

import 'package:flutter/material.dart';

import '../../../components/displays/app_button.dart';
import '../../../utils/colours.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  void resetTimer() => setState(() => seconds = maxSeconds);
  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = timer == null ? false : timer!.isActive;

    final isCompleted = seconds == maxSeconds || seconds == 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: 1- seconds / maxSeconds,
                valueColor: AlwaysStoppedAnimation(Colors.white),
                backgroundColor: Colors.green,
                strokeWidth: 12,
              ),
              Center(
                child: Text(
                  '$seconds',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 80),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        isRunning || !isCompleted
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (isRunning) {
                        stopTimer(reset: false);
                      } else {
                        startTimer(reset: false);
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(blackColor)),
                    child: Text(isRunning ? "pause" : "Resume"),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      stopTimer();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(blackColor)),
                    child: Text("cancel"),
                  ),
                ],
              )
            : AppButton(
                text: "Start",
                onPress: () {
                  startTimer();
                },
                buttonColour: primaryColor)
      ],
    );
  }
}
