import 'package:flutter/material.dart';

Color primaryColor = const Color(0xFF79C4EC);
Color backgroundColor = const Color(0xFF060B12);
Color cardColor = const Color(0x0d51c7e1);
Color cardBorderColor = const Color(0xFF1D3050);

Color lightTeal = const Color(0xFF7AE7E7);
Color lightGold = const Color(0xFFE1D356);


final ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
    headline2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
    headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
    headline4: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300, fontFamily: 'Poppins'),
    bodyText1: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
    bodyText2: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w300, fontFamily: 'Poppins'),
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
