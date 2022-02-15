import 'dart:async';

import 'package:derma/src/base/nav.dart';
import 'package:derma/src/ui/pages/complete_session_page.dart';
import 'package:derma/src/ui/widgets/button_widget.dart';
import 'package:derma/src/ui/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _controller;
  Animatable<Color?>? color;

  late int seconds;

  Timer? _vibrationTimer;
  Timer? stopTime;
  late AppLifecycleState _notification;

  @override
  void dispose() {
    debugPrint('Dispose Called');
    _dispose();
    super.dispose();
  }

  late TimerController _timerController;

  void _startVibration() {
    if (widget.vibrationEnabled) {
      _vibrationTimer = Timer.periodic(
        const Duration(milliseconds: 300),
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    late Color _begin, _end;
    switch (widget.treatmentType) {
      case 'COMBINATION THERAPY':
        _begin = Colors.red.shade900;
        _end = Colors.blue.shade900;
        break;
      case 'ANTI-AGING THERAPY':
        _begin = Colors.red.shade900;
        _end = Colors.red.shade300;
        break;
      case 'ACNE THERAPY':
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
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }
  Future<void> start() async{
    _startVibration();
    _controller.repeat();
    _timerController.startTimeout();
}
  Future<void> stop() async{
    _stopVibration();
    _controller.stop();
    _timerController.pauseTimer();
  }

   Future<void> _dispose() async {
     if (widget.vibrationEnabled) {
       _vibrationTimer!.cancel();
     }
     _controller.dispose();
     Wakelock.disable();
     ScreenBrightness().resetScreenBrightness();
     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
     WidgetsBinding.instance?.removeObserver(this);
   }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state)async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
       // _dispose();
        debugPrint('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        final result=await cancelDialog(context);
        if(result){
          AppNavigation.to(context, CompleteSessionScreen());
        }
        start();
        debugPrint('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        stop();

        break;
      case AppLifecycleState.detached:
        debugPrint('appLifeCycleState detached');
        break;
      default:
        debugPrint('Default');
        break;
    }
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
                       start();
                     } else {
                      stop();
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
                              width: 1,
                            ),
                          ),
                        ),
                        const Center(
                          child: SizedBox(
                            width: 215,
                            child: Divider(
                              height: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Center(
                          child: SizedBox(
                            height: 215,
                            child: VerticalDivider(
                              width: 1,
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

        );
      },
    );
  }

}
