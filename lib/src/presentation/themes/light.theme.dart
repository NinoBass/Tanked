import 'package:flutter/material.dart';
import 'package:tanked/src/presentation/resources/colors.res.dart';

//the light theme
ThemeData lightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  scaffoldBackgroundColor: white,
  textTheme: Typography.englishLike2018.apply(
    fontFamily: "BRFirmaRegular",
    bodyColor: dark,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      fontSize: 14,
      color: labelColor,
    ),
    labelStyle: TextStyle(
      fontSize: 14,
      color: labelColor,
    ),
    floatingLabelStyle: TextStyle(
      color: Color(0xFFA1A5AD),
    ),
    fillColor: grey,
    border: InputBorder.none,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    centerTitle: true,
    foregroundColor: Colors.white,
    elevation: 0,
    shadowColor: Colors.transparent,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
