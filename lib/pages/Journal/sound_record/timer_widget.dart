import 'dart:async';

import 'package:flutter/material.dart';

import '../../../components/displays/app_button.dart';
import '../../../utils/colours.dart';

class TimerController extends ValueNotifier<bool> {
  TimerController({bool isPlaying = false}) : super(isPlaying);

  void startTimer() => value = true;
  void stopTimer() => value = false;
}

class TimerWidget extends StatefulWidget {
  final TimerController controller;

  const TimerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  static const maxSeconds = 60;
  int seconds = 0;

  Duration duration = Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (widget.controller.value) {
        startTimer();
      } else {
        stopTimer();
      }
    });
  }

  // void resetTimer() => setState(() => duration = Duration());

  void resetTimer() {
    setState(() => seconds = 0);
  }

  // void addTime() {
  //   final addSeconds = 1;

  //   setState(() {
  //     final seconds = duration.inSeconds + addSeconds;

  //     if (seconds < 0) {
  //       timer?.cancel();
  //     } else {
  //       duration = Duration(seconds: seconds);
  //     }
  //   });
  // }

  void addTime() {
    setState(() {
      seconds++;

      if (seconds < 0) {
        timer?.cancel();
      }
    });
  }

  void startTimer({bool reset = true}) {
    if (!mounted) return;
    if (reset) {
      resetTimer();
    }

    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool reset = true}) {
    if (!mounted) return;
    if (reset) {
      resetTimer();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: seconds / maxSeconds,
                valueColor: AlwaysStoppedAnimation(Colors.white),
                backgroundColor: Colors.white,
                strokeWidth: 12,
              ),
              Center(
                child: Text(
                  '00:${seconds.toString().padLeft(2, '0')}',
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
      ],
    );
  }
}
