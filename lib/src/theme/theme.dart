import 'package:app_movie/src/theme/pallette.dart';
import 'package:flutter/material.dart';

ThemeData appLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: azureColor,
    buttonColor: azureColor,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: whiteColor,
    primaryIconTheme: _appIconTheme(base.iconTheme),
    textTheme: _appTextTheme(base.textTheme),
    iconTheme: _appIconTheme(base.iconTheme),
  );
}

// dedault icon theme
IconThemeData _appIconTheme(IconThemeData original) {
  return original.copyWith(color: mainFontColor);
}

// default text theme
TextTheme _appTextTheme(TextTheme base) {
  return base.copyWith(
    caption: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Jost',
      color: darkGreyFontColor,
      // color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    headline1: TextStyle(
      fontSize: 25.0,
      fontFamily: 'Jost',
      color: mainFontColor,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Jost',
      color: mainFontColor,
      // color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontSize: 18.0,
      fontFamily: 'Jost',
      // color: darkGreyFontColor,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Jost',
      color: darkGreyFontColor,
      // color: Colors.black,
      // fontWeight: FontWeight.bold,
    ),
  );
}
