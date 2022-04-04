import 'package:flutter/material.dart';

ThemeData myThemeData() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(color: Colors.black45),
      backgroundColor: Colors.white10,
      //  경계선 제거
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black87
      )
    ),
    textTheme: const TextTheme(
      subtitle1: TextStyle(fontSize: 40, height: 1.2),
      subtitle2: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, height: 1.2),
      headline5: TextStyle(fontSize: 30, color: Colors.black45),
      headline6: TextStyle(fontSize: 30, color: Colors.yellow),
      headline4: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
      caption: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
    ),
  );
}