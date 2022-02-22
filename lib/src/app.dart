import 'package:derma/src/base/nav.dart';
import 'package:derma/src/base/themes.dart';
import 'package:derma/src/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Derma ',
      theme: AppTheme.lightTheme,
      routes: AppNavigation.routes,
      home: const HomePage(),
    );
  }
}
