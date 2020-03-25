import 'package:flutter/material.dart';

class Constants {
  static String appName = "悦读";

  //Color for theme
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Color(0xff8d6e63);
  static Color darkAccent = Color(0xff8d6e63);
  static Color lightBG = Colors.white;
  static Color darkBG = Colors.black;
  static Color searchColor = Color(0xffeaeaea);
  static Color searchText = Color(0xffcdc1c5);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    cursorColor: lightAccent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    scaffoldBackgroundColor: lightBG,
    accentColor: lightAccent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
          title: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      )),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: lightBG,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
