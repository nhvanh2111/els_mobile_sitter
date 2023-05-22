import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color greenBg = fromHex('9DE5B1');

  static Color redFail = fromHex('FF0101');

  static Color whiteE3 = fromHex('E3E3E3');

  static Color whiteEE = fromHex('EEEEEE');

  static Color whiteFA = fromHex('FAFAFA');

  static Color whiteF3 = fromHex('F3F3F3');

  static Color grayED = fromHex('EDEDED');

  static Color grayA3 = fromHex('A39797');

  static Color gray43 = fromHex('434343');

  static Color gray4A = fromHex('4A4A4A');

  static Color gray69 = fromHex('696969');

  static Color gray9E = fromHex('9E9E9E');

  static Color gray75 = fromHex('757171');

  static Color grayAE = fromHex('AEAEAE');

  static Color gray61 = fromHex('616161');

  static Color primaryColor = fromHex('5CB85C');

  static Color redErrorText = fromHex('#c53530');

  static Color yellowButton = fromHex("FBCC16");

  static Color blue1 = fromHex('1A96F0');

  static Color red1 = fromHex('F54336');

  static Color purple1 = fromHex('7210FF');

  static Color blueSky1 = fromHex('00BCD3');

  static Color yellow1 = fromHex('F4B828');

  static Color yellowFF = fromHex('FFC02D');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
