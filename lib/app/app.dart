import 'routes-manager.dart';
import 'package:aquae_florentis/presentation/resources/theme-manager.dart';

import '../presentation/resources/color-manager.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal(); //private constructor

  static const MyApp instance = MyApp._internal(); // final single instance of MyApp

  factory MyApp()=> instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aquae Florentis',
      color: ColorManager.primaryColor,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}