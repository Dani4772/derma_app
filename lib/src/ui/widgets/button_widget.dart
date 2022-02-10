import 'package:derma/src/base/themes.dart';
import 'package:derma/src/ui/modals/cancel_dialog.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool _absorb = false;

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
              onPressed: _absorb ? null : () => cancelDialog(context),
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
