import 'package:flutter/material.dart';

class HCMColors {
  static const Color backgroundColor = Color(0xFFF8F8F8);
  static const Color white = Color(0xFFFFFFFF);
  static const Color colorGreen8cb96f = Color(0xff8cb96f);
  static const Color colorYellowfdb800 = Color(0xfffdb800);
  static const Color colorOrangee47d40 = Color(0xffe47d40);
  static const Color colorRedc10707 = Color(0xffc10707);
  static const Color colorBlue0054a6 = Color(0xff0054a6);
  static const Color blue0060af = Color(0xff0060af);
  static const Color blue1479d2 = Color(0x800060af);
  static const Color colorBlue140060af = Color(0x140060af);
  static const Color colorBlue140056ac = Color(0x140056ac);
  static const Color black1a1a1a = Color(0xff1a1a1a);
  static const Color colorGreyf2f4fb = Color(0xfff2f4fb);
  static const Color colorGreye6e8f2 = Color(0xffe6e8f2);
  static const Color colorGrey0e606eaa = Color(0x0e606eaa);
  static const Color black656565 = Color(0xFF656565);
  static const Color black25282b = Color(0xFF25282b);
  static const Color black0a0a0a = Color(0xFF0a0a0a);
  static const Color greyE3E3E3 = Color(0xFFE3E3E3);
  static const Color greyf7f7f7 = Color(0xFFf7f7f7);
  static const Color grey707070 = Color(0xFF707070);
  static const Color greyadadad = Color(0xFFadadad);
  static const Color greye0e0e0 = Color(0xffe0e0e0);
  static const Color greycecfd2 = Color(0xffcecfd2);
  static const Color greyc8c9cc = Color(0xffc8c9cc);

  static Color getIndicatorColor(int index) {
    switch (index) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        return HCMColors.colorGreen8cb96f;
      case 6:
      case 7:
      case 8:
      case 9:
      case 10:
      case 11:
        return HCMColors.colorYellowfdb800;
      case 12:
      case 13:
      case 14:
      case 15:
      case 16:
      case 17:
        return HCMColors.colorOrangee47d40;
      case 18:
      case 19:
      case 20:
      case 21:
        return HCMColors.colorRedc10707;
      default:
        return Colors.transparent; // Default color if index out of range
    }
  }
}
