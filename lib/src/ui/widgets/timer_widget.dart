import 'dart:async';

import 'package:derma/src/base/nav.dart';
import 'package:derma/src/ui/pages/complete_session_page.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    Key? key,
    required this.seconds,
    required this.context,
   // required this.stopTimer
  }) : super(key: key);
  final int seconds;
  final BuildContext context;
 // final Function(Timer) stopTimer;

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  final interval = const Duration(seconds: 1);
  int currentSeconds = 0;

  String get timerText =>
      '${((widget.seconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((widget.seconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  late Timer timer;

  startTimeout() {
    var duration = interval;
    timer = Timer.periodic(duration, (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= widget.seconds) {
          timer.cancel();
          AppNavigation.to(context, const CompleteSessionScreen());
        }
      });
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timerText,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 68,
      ),
    );
  }
}
