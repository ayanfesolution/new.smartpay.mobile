import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../constants.dart';

class SmartPayTextButton extends StatelessWidget {
  const SmartPayTextButton({
    super.key,
    required this.onTap,
    required this.title,
    this.color = kBLKCOLOUR,
    this.fontSize = 16,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = FontWeight.w400,
  });

  final Function() onTap;
  final String title;
  final Color color;

  final double fontSize;
  final FontStyle fontStyle;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: kTextStyleCustom(
          color: color,
          fontSize: fontSize,
          fontStyle: fontStyle,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
