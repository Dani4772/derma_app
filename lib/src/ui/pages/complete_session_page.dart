import 'package:audioplayers/audioplayers.dart';
import 'package:derma/src/ui/modals/complete_dialog.dart';
import 'package:flutter/material.dart';

import '../../base/nav.dart';
import 'home_page.dart';

class CompleteSessionScreen extends StatelessWidget {
   CompleteSessionScreen({Key? key}) : super(key: key){
     final player = AudioCache();
     player.play('finish.mp3',volume: 0.09);
   }



  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async {
       await AppNavigation.replace(context, const HomePage());
       return true;
      },
      child: Scaffold(
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                tileMode: TileMode.clamp,
                colors: [
                  Color(0xff28C3F3),
                  Color(0xff8171B7),
                  Color(0xffFA163F),
                  // Theme.of(context).colorScheme.secondary,
                  // Theme.of(context).primaryColor,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/completelogo.png',
                  width: 284,
                  height: 50,
                ),
                const SizedBox(height: 30.5),
                completeDialog(context),
              ],
            )
          ),
        ),
      ),
    );
  }
}
