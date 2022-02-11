import 'dart:async';
import 'package:derma/src/base/nav.dart';
import 'package:derma/src/base/themes.dart';
import 'package:derma/src/ui/modals/cancel_dialog.dart';
import 'package:derma/src/ui/pages/complete_session_page.dart';
import 'package:flutter/material.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

class ButtonWidget extends StatefulWidget {
   final Function(bool) waitForAction;
  const ButtonWidget({Key? key,required this.waitForAction}) : super(key: key);
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool _absorb = true;
  late StreamSubscription<double> _subscription;
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _subscription = PerfectVolumeControl.stream.listen((value) {
      //
      if (mounted) {
        setState(() {
          _absorb = !_absorb;
        });
      }
      debugPrint(value.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Button Rebuild');
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 34, 36, 0),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              title: 'CANCEL SESSION',
              primary: Colors.white,
              onPrimary: Colors.black,

              onPressed: _absorb ? null : ()async {
                widget.waitForAction(true);
               final _isFinished= await cancelDialog(context);
               if(_isFinished){
                 AppNavigation.to(context, const CompleteSessionScreen());
               }
               else{
                 widget.waitForAction(false);
               }
              },
            ),
          ),
          const SizedBox(width: 10),
          AppButton(
            title: '',
            primary: Colors.white,
            onPrimary: Colors.black,
            size: const Size(40, 58),
            onPressed: () {
              setState(() {
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
            style: const TextStyle(fontSize: 18),
          ),
    );
  }
}
