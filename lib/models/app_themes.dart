import 'package:flutter/material.dart';

enum AppTheme { LightTheme, DarkTheme }

final appThemeData = {
  AppTheme.LightTheme: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    primarySwatch: Colors.blue,
    //colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue)
  ),
  AppTheme.DarkTheme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.red,
      primarySwatch: Colors.red,
      //colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red)
  ),
};
