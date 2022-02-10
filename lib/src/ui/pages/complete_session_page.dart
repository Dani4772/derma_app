import 'package:derma/src/ui/modals/complete_dialog.dart';
import 'package:flutter/material.dart';

class CompleteSessionScreen extends StatelessWidget {
  const CompleteSessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.pink,
                // Theme.of(context).colorScheme.secondary,
                // Theme.of(context).primaryColor,
              ],
            ),
          ),
          child: completeDialog(context),
        ),
      ),
    );
  }
}
