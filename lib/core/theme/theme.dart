import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme=ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.cyan.withOpacity(0.1),
        hoverColor: Color(0xffc0d6df),
        cardColor: Colors.grey[300],
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey.shade500,
            focusColor: Colors.white),
        appBarTheme: const AppBarTheme(
            color: Color(0xffc0d6df),
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 25)),
        textTheme: const TextTheme(bodySmall: TextStyle(color: Colors.black)));
  static final darktheme = ThemeData(
      brightness: Brightness.dark,
      hoverColor: Color.fromARGB(255, 58, 55, 55),
      primarySwatch: Colors.blue,
      cardColor: const Color.fromARGB(255, 174, 58, 58),
      inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color.fromARGB(255, 58, 55, 55),
          focusColor: Colors.black),
      appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 38, 38, 38),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 25)),
      scaffoldBackgroundColor: const Color.fromARGB(255, 38, 38, 38),
    );
}
