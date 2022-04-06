import 'dart:math';

import 'package:flutter/material.dart';

//  Device 기기에 따른 크기 통일
class MyScreenUtil {
  static const Size defaultSize = Size(360, 640);
  static late final MyScreenUtil _instance;

  // late BuildContext context;
  late Size uiSize;
  late double _screenWidth;
  late double _screenHeight;
  late bool _minTextAdapt;  //  최소 너비, 높이에 따라 텍스트 조정

  MyScreenUtil._();

  factory MyScreenUtil() => _instance;

  // static void setContext(BuildContext context) {
  //   _instance.context = context;
  // }

  static void init(
      {
        required BuildContext context,
        Size designSize = defaultSize,
        bool minTextAdapt = false,
      }) {
    _instance = MyScreenUtil._()
      ..uiSize = designSize
      .._screenWidth = MediaQuery.of(context).size.width
      .._screenHeight = MediaQuery.of(context).size.height
      .._minTextAdapt = minTextAdapt;
  }

  double get scaleWidth => _screenWidth / uiSize.width;
  double get scaleHeight => _screenHeight / uiSize.height;
  double get scaleText =>
      _minTextAdapt ? min(scaleWidth, scaleHeight) : scaleWidth;

  double setWidth(num width) => width * scaleWidth;
  double setHeight(num height) => height * scaleHeight;
  double setSp(num fontSize) => fontSize * scaleText;
}

extension SizeExtension on num {
  double get w => MyScreenUtil().setWidth(this);

  double get h => MyScreenUtil().setHeight(this);

  double get sp => MyScreenUtil().setSp(this);
}