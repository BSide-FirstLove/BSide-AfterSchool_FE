import 'package:flutter/material.dart';

//  리소스 낭비이지 않을까
class MyTextStyle {
  static const TextStyle bodyTextLarge1 =
    TextStyle(fontSize: 36, color: Color(0xFF2E2E2E), fontWeight: FontWeight.w400);
  static const TextStyle bodyTextLarge2 =
    TextStyle(fontSize: 36, color: Color(0xFF2E2E2E), fontWeight: FontWeight.w800);
  static const TextStyle bodyTextLarge3 =
    TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold);
  static const TextStyle bodyTextMedium1 =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: Color(0xFF000000));
  static const TextStyle bodyTextMedium2 =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: Color(0xFFFFB038));
  static const TextStyle bodyTextLabel1 =
    TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400);
  static const TextStyle bodyTextAlert =
    TextStyle(fontWeight: FontWeight.w400, color: Color(0xFFBABABA), fontSize: 13);

  //  add_info_screen
  static const TextStyle addInfoTitleLarge =
    TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 22);
  static const TextStyle addInfoTitleSmall =
    TextStyle(fontWeight: FontWeight.w400, color: Color(0xFFFFDCA7), fontSize: 14);
  static const TextStyle addInfoBodyLabel =
    TextStyle(fontWeight: FontWeight.w400, color: Color(0xFFAEAEAE), fontSize: 14);
  static const TextStyle addInfoName =
    TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF3B3B3B), fontSize: 16, letterSpacing: 2);
  //  input_instar_screen
  static const TextStyle inputInstarTitle =
    TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16);
  static const TextStyle inputInstarAction =
    TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 16);
  static const TextStyle inputInstarField =
    TextStyle(fontWeight: FontWeight.w400, color: Color(0xFFFFB038), fontSize: 16);
  //
  static const TextStyle selectImageButton =
    TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 18);
  static const TextStyle selectImageButtonRed =
  TextStyle(fontWeight: FontWeight.w400, color: Color(0xFFE64646), fontSize: 18);
}