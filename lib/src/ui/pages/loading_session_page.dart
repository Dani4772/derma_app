import 'dart:async';
import 'package:derma/src/base/themes.dart';
import 'package:derma/src/ui/pages/session_page.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../base/assets.dart';
import '../../base/nav.dart';
import '../../utils/const.dart';

class LoadingSession extends StatefulWidget {
  final int time;
  final bool vibrationEnabled;
  final String treatmentType;
  const LoadingSession({Key? key,required this.time,
    required this.treatmentType,
    required this.vibrationEnabled,}) : super(key: key);

  @override
  _LoadingSessionState createState() => _LoadingSessionState();
}

class _LoadingSessionState extends State<LoadingSession> {
 late Timer timer;
   int progress=0;
 @override
  void initState() {
    // TODO: implement initState
   timer=Timer.periodic(const Duration(seconds: 1), (timer) {
     if(progress==100){
       AppNavigation.to(
         context,
         SessionPage(
           time: widget.time ,
           vibrationEnabled: widget.vibrationEnabled,
           treatmentType: widget.treatmentType,
         ),
       );
     }
     else{
      progress += 20;
     }

     setState(() {

     });
   });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final _padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0 + _padding.top),
        child: Container(
          padding: EdgeInsets.only(
            bottom: 28,
            top: 32 + _padding.top,
          ),
          color: Colors.white,
          child: Image.asset(
            Assets.logo,
            height: 40,
            width: 153,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30,right: 102,left: 111,bottom:40),
              child: Image.asset('assets/loading.png',width: 215,height: 272.68,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55,right: 55),
              child: Text(
                'Instructions:'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'SegoeBold',
                  color: kDescriptionTextColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 55,
                right: 55,
                top: 22,
                bottom: 40,
              ),
              child: Text(
                'Make sure your phone and skin are clean and dry,then move your screen along the surface '
                    'of your skin slowly for the duration of your treatment-paying special attention to '
                    'any areas of concerns',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDescriptionTextColor,
                  fontSize: 17,
                ),
              ),
            ),
           Padding(
            padding: const EdgeInsets.only(left: 33.1,right: 33.1,bottom: 23),
             child: StepProgressIndicator(
               totalSteps: 100,
               currentStep: progress,
               size: 15,
               padding: 0,
               selectedColor: Colors.yellow,
               unselectedColor: Colors.cyan,
               selectedGradientColor: const LinearGradient(
                 begin: Alignment.topLeft,
                 end: Alignment.bottomRight,
                 colors: [AppTheme.pinkColor, AppTheme.blueColor],
               ),
               unselectedGradientColor: const LinearGradient(
                 begin: Alignment.topLeft,
                 end: Alignment.bottomRight,
                 colors: [Color(0xffD2D2D2),Color(0xffD2D2D2)],
               ),
             ),
          ),
            const Padding(
              padding: EdgeInsets.only(left: 55,right: 68),
              child: Text('Loading... Your session will begin soon',style: TextStyle(color: Color(0xff29bcef,),fontSize: 17,),textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}
