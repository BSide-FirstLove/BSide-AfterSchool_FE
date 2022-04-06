import 'package:flutter/material.dart';

ThemeData myThemeData() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(color: Color(0xFFAEAEAE)),
      backgroundColor: Colors.white10,
      foregroundColor: Colors.black12,
      //  경계선 제거
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
    ),
    fontFamily: 'Pretendard',
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Color(0x12000000), width: 1),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Color(0x12000000), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Color(0x12000000), width: 1),
      ),
      fillColor: Color(0xFFF2F3F5),
      filled: true,
    ),
    textTheme: const TextTheme(
      // subtitle1: TextStyle(fontSize: 40, height: 1.2),
      // subtitle2: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, height: 1.2),
    ),
  );
}