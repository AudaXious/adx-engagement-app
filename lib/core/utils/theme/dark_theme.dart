import 'package:flutter/material.dart';

Color secondaryColor = const Color(0xFF79C4EC);
Color accentColor = const Color(0xFFEBEDED);
Color backgroundColor = const Color(0xFF060B12);
Color onBoardingBackgroundColor = const Color(0xFF13161E);
Color cardColor = const Color(0x0d51c7e1);
Color cardColor2 = const Color(0xFF2A3C46);
Color spacesCardColor = const Color(0xE6080E17);
Color cardBorderColor = const Color(0xFF2A3C46);
Color bannerColor1 = const Color(0xFF162530);
Color taskChipBorderColor = const Color(0xFFB2B3B6);
Color dividerColor = const Color(0xFFB2B3B6);

Color lightTeal = const Color(0xFF7AE7E7);
Color lightGreen = const Color(0xFF6DE6AE);
Color lightGold = const Color(0xFFE1D356);
Color blackTextColor = const Color(0xFF060B12);
Color greyTextColor = const Color(0xFFCCCACA);
Color cardTitleColor = const Color(0xFFE8E8E8);
Color cardDescriptionColor = const Color(0xFFE8E8E8);
Color textInputBorderColor = const Color(0xFF555656);
Color searchTextInputBorderColor = const Color(0xFFE8E8E8);
Color fadedTextColor = const Color(0xFF757575);
Color activeTabColor = const Color(0xFF13161E);
Color inActiveBottomBarColor = const Color(0xFFE5E5E5);
Color yellowBarColor = const Color(0xFFFFAA3E);
Color purpleBarColor = const Color(0xFFB63EFF);
Color greenBarColor = const Color(0xFF3EFFDC);
Color darkOrange = const Color(0xFFD04740);


final ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800, fontFamily: 'Poppins'),
    displayMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
    displaySmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
    headlineMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300, fontFamily: 'Poppins'),
    bodyLarge: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
    bodyMedium: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w300, fontFamily: 'Poppins'),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: secondaryColor,
    background: backgroundColor,
    brightness: Brightness.dark,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: backgroundColor
  ),
  useMaterial3: true
);
