// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class AppColor {
  static LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, Color(0xff1e3873)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static Color primaryColor = Color.fromARGB(255, 56, 147, 252);
  //static Color primaryColor = Color.fromARGB(255, 56, 147, 252);
  static Color arrowRed = Color.fromARGB(255, 255, 0, 0);
  static Color arrowGreen = Color.fromARGB(255, 0, 255, 64);
  static Color greenbutton = Color.fromARGB(255, 0, 121, 30);
  static Color primarySoft = Color.fromARGB(255, 0, 76, 175);
  static Color primaryExtraSoft = Color.fromARGB(255, 241, 245, 255);
  static Color secondary = Color.fromARGB(255, 235, 151, 171);
  static Color secondarySoft = Color.fromARGB(255, 170, 170, 170);
  static Color secondaryExtraSoft = Color.fromARGB(255, 230, 230, 230);
  static Color warning = Color.fromARGB(255, 255, 109, 24);
  static Color dark = Color.fromARGB(255, 53, 53, 52);
  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color.fromARGB(255, 255, 62, 110);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}
