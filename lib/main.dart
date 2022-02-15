import 'package:derma/src/app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Future.delayed(const Duration(milliseconds: 1000));
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}
