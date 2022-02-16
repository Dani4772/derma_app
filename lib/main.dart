import 'package:derma/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async{
  await Future.delayed(const Duration(seconds: 1));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}