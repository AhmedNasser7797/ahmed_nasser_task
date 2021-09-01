import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  final String key = "theme_data";

  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    dividerColor: Color(0xff9C9AC2),
    buttonColor: Colors.blue,
    primaryColor: Colors.blue,
    fontFamily: "OpenSans",
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    cardColor: Colors.grey.withOpacity(0.1),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
      labelStyle: TextStyle(
        color: Colors.grey,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: Color(0xff64668E).withOpacity(0.5),
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: Color(0xff64668E).withOpacity(0.5),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: Color(0xff64668E).withOpacity(0.5),
          width: 1,
        ),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
