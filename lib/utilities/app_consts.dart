
import 'package:flutter/material.dart';

class AppColor {

  static Color primary = Color(0xFF295C97);
  static Color secondary = Color(0xFF2fa744);
  static Color accent = Color(0xff81CC0A);
  static Color darkYellow = Color(0xffFCBF31);
  static Color pink = Color(0xffD820A4);
  static Color blue = Color(0xff6095EA);
  static Color red = Color(0xffE70146);
  static Color darkGreen = Color(0xff3B7916);
  static Color whatsapp = Color(0xff25CC64);
  static Color white = Colors.white;
  static Color disabled = Colors.grey[400];
  static Color disabledButton = Colors.grey[400];
  static Color inputBorderBottom = Colors.grey[400];
  static Color border = Colors.grey[300];

}

class AppBoxShadow {
  static BoxShadow type1 = BoxShadow(
    color: Colors.black45,
    offset: Offset(0, 0),
    blurRadius: 3,
    spreadRadius: -1
  );
  
  static BoxShadow type2 = BoxShadow(
    color: Colors.black45,
    offset: Offset(0, -2),
    blurRadius: 5,
    spreadRadius: -4
  );

  static BoxShadow type3 = BoxShadow(
    color: Colors.black26,
    offset: Offset(2, 2),
    blurRadius: 2,
    spreadRadius: -1
  );
}