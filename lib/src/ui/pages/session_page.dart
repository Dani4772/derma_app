import 'dart:async';

import 'package:derma/src/ui/widgets/button_widget.dart';
import 'package:derma/src/ui/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock/wakelock.dart';

import '../modals/cancel_dialog.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({
    Key? key,
    required this.time,
    required this.treatmentType,
    required this.vibrationEnabled,
  }) : super(key: key);

  final int time;
  final bool vibrationEnabled;
  final String treatmentType;

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animatable<Color?>? color;

  late int seconds;

  Timer? _vibrationTimer;
  Timer? stopTime;
  @override
  void dispose() {
    debugPrint('Dispose Called');
    if (widget.vibrationEnabled) {
      _vibrationTimer!.cancel();
    }
    _controller.dispose();
    Wakelock.disable();
    ScreenBrightness().resetScreenBrightness();
    super.dispose();
  }

  late TimerController _timerController;

  void _startVibration() {
    if (widget.vibrationEnabled) {
      _vibrationTimer = Timer.periodic(
        const Duration(milliseconds: 1000),
        (timer) async {
          await Vibrate.vibrate();
        },
      );
    }
  }

  void _stopVibration() {
    if (widget.vibrationEnabled) {
      _vibrationTimer!.cancel();
    }
  }

  @override
  void initState() {
    seconds = widget.time;
    _timerController = TimerController(seconds: seconds);
    Wakelock.enable();
    ScreenBrightness().setScreenBrightness(1.0);
    _startVibration();

    late Color _begin, _end;
    switch (widget.treatmentType) {
      case 'Combination Therapy':
        _begin = Colors.red.shade900;
        _end = Colors.blue.shade900;
        break;
      case 'Aging Therapy':
        _begin = Colors.red.shade900;
        _end = Colors.red.shade300;
        break;
      case 'Acne Therapy':
        _begin = Colors.blue.shade900;
        _end = Colors.blue.shade300;
        break;
    }
    color = TweenSequence<Color?>(
      [
        TweenSequenceItem(
          tween: ColorTween(begin: _begin, end: _end),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: _end, end: _begin),
          weight: 1.0,
        ),
      ],
    );
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 500,
      ),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: color!.evaluate(
            AlwaysStoppedAnimation(
              _controller.value,
            ),
          ),
          body: Center(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                   ButtonWidget(waitForAction: (isPaused)
                   {
                     if (!isPaused) {
                       _startVibration();
                       _controller.repeat();
                       _timerController.startTimeout();
                     } else {
                       _stopVibration();
                       _controller.stop();
                       _timerController.pauseTimer();
                     }
                     isPaused = !isPaused;
                     setState(() {});
                   },),
                  SizedBox(
                    height: 216,
                    child: Stack(
                      children: [
                        Container(
                          height: 216,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                        ),
                        const Center(
                          child: SizedBox(
                            width: 215,
                            child: Divider(
                              thickness: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Center(
                          child: SizedBox(
                            height: 215,
                            child: VerticalDivider(
                              thickness: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 45.0),
                    child: TimerWidget(
                      timerController: _timerController,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     if (_isPaused) {
          //       _startVibration();
          //       _timerController.startTimeout();
          //       _controller.repeat();
          //     } else {
          //       _stopVibration();
          //       _timerController.pauseTimer();
          //       _controller.stop();
          //     }
          //     _isPaused = !_isPaused;
          //     setState(() {});
          //   },
          //   child: Icon(_isPaused ? Icons.play_arrow : Icons.stop),
          // ),
        );
      },
    );
  }

  var _isPaused = false;
}
