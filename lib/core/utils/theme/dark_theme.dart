import 'package:flutter/material.dart';

Color primaryColor = const Color(0xFF79C4EC);
Color backgroundColor = const Color(0xFF060B12);

final ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
    headline2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
    headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
    headline4: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300, fontFamily: 'Poppins'),
    bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
    bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, fontFamily: 'Poppins'),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    background: backgroundColor,
    brightness: Brightness.dark,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: backgroundColor
  ),
  useMaterial3: true
);
