import 'dart:async';

import 'package:derma/src/base/nav.dart';
import 'package:derma/src/ui/pages/complete_session_page.dart';
import 'package:flutter/material.dart';
import 'package:reusables/reusables.dart';

class TimerController extends ChangeNotifier {
  TimerController({required this.seconds}) {
    currentSeconds = seconds;
  }

  int seconds;

  final interval = const Duration(seconds: 1);
  late int currentSeconds;
  late BuildContext context;

  late Timer timer;

  void pauseTimer() => timer.cancel();

  void startTimeout() {
    var duration = interval;
    timer = Timer.periodic(duration, (timer) {
      currentSeconds--;
      if (currentSeconds <=0) {

        timer.cancel();
        AppNavigation.navigateRemoveUntil(context,  CompleteSessionScreen());
      }
      notifyListeners();
    });
  }

  String get timerText =>
      '${(currentSeconds ~/ 60).toString().padLeft(2, '0')}:${(currentSeconds % 60).toString().padLeft(2, '0')}';

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

class TimerWidget extends ControlledWidget<TimerController> {
  const TimerWidget({
    Key? key,
    required this.timerController,
  }) : super(key: key, controller: timerController);

  final TimerController timerController;

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> with ControlledStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.controller.context = context;
      widget.controller.startTimeout();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.controller.timerText,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 68,
      ),
    );
  }
}
