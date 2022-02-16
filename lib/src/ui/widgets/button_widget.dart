import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:derma/src/base/nav.dart';
import 'package:derma/src/base/themes.dart';
import 'package:derma/src/ui/modals/cancel_dialog.dart';
import 'package:derma/src/ui/pages/complete_session_page.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
   final Function(bool) waitForAction;
  const ButtonWidget({Key? key,required this.waitForAction}) : super(key: key);
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool _absorb = true;

  final player = AudioCache();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    debugPrint('Button Rebuild');
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 34, 36, 0),
      child: Row(
        children: [
        _absorb==false?  Expanded(
            child: AppButton(
              title: 'CANCEL SESSION',
              primary: Colors.white,
              onPrimary: Colors.black,

              onPressed: _absorb ? null : ()async {
                widget.waitForAction(true);
               final _isFinished= await cancelDialog(context);
               if(_isFinished){
                 AppNavigation.replace(context,  CompleteSessionScreen());
               }
               else{
                 widget.waitForAction(false);
               }
              },
            ),
          ):const Expanded(child: SizedBox(width: double.infinity,)),
          const SizedBox(width: 10),
          AppButton(
            title: '',
            primary: Colors.white,
            onPrimary: Colors.black,
            size: const Size(40, 58),
            onPressed: () {
              setState(() {
                player.play('unlock.mp3',volume: 0.5);
                _absorb = !_absorb;
              });
            },
            child: Icon(
              _absorb ? Icons.lock : Icons.lock_open_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.child,
    this.primary = AppTheme.blueColor,
    this.onPrimary = Colors.white,
    this.size,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Widget? child;
  final String title;
  final Color primary;
  final Color onPrimary;
  final Size? size;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primary,
        onPrimary: onPrimary,
        minimumSize: size ?? const Size(double.infinity, 58),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: child ??
          Text(
            title,
            style: const TextStyle(fontSize: 18,fontFamily: 'Segoe'),
          ),
    );
  }
}
