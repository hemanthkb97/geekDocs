import 'package:flutter/material.dart';

class ColorConstants {
  ColorConstants._();
  static final ColorConstants _instance = ColorConstants._();
  factory ColorConstants() => _instance;
  Color primaryColor = const Color(0xFFbe1609);
  Color primaryDarkColor = const Color(0xffbe1609);
  Color lightBackgroundColor = Colors.white;
  Color darkBackgroundColor = Colors.black;
  Color primaryTextLight = Colors.black;
  Color primaryTextDark = Colors.white;
  Color accentColor = const Color(0xffA39BDB);
}
