import 'package:flutter/material.dart';
import 'app_colors.dart';

class SmartPayThemeData {
  static ThemeData appThemeData(BuildContext context) {
    return ThemeData(
      primarySwatch: customKPrimaryColor,
      primaryColor: kPRYCOLOUR,
      fontFamily: 'SF Pro Display',
    );
  }
}
