import 'package:flutter/material.dart';

//TODO create texttheme and complete dark mode of app
//the dark theme
ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  textTheme: Typography.englishLike2018.apply(
    fontFamily: "Poppins",
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.transparent,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
    shadowColor: Colors.transparent,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
