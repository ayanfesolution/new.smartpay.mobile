import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../constants.dart';
import '../dimensions.dart';

class SmartPayTextField extends StatelessWidget {
  const SmartPayTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.enable = true,
    this.keyboardType,
    this.obscureText = false,
    this.onEditingComplete,
    this.suffixIcon,
    this.onChange,
    this.icon,
  });
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool enable, obscureText;
  final TextInputType? keyboardType;
  final Function()? onEditingComplete;
  final Widget? suffixIcon;
  final Function(String)? onChange;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(getScreenHeight(15)),
      borderSide: BorderSide(
        width: getScreenHeight(0.5),
        style: BorderStyle.none,
        color: kSECCOLOUR,
      ),
    );

    return TextFormField(
      controller: controller,
      validator: validator,
      enabled: enable,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onEditingComplete: onEditingComplete,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: ' $hintText',
        filled: true,
        fillColor: kTEXTFIELDBACKGROUND,
        prefixIcon: icon,
        hintStyle: kTextStyleReguler(fontSize: 14, color: kLightGray),
        enabledBorder: outlineInputBorder,
        border: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getScreenHeight(15)),
          borderSide: BorderSide(
            width: getScreenHeight(1),
            style: BorderStyle.solid,
            color: kSECCOLOUR,
          ),
        ),
        errorStyle: kTextStyleCustom(color: kSECCOLOUR, fontSize: 10),
        focusedBorder: outlineInputBorder,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getScreenHeight(15)),
          borderSide: BorderSide(
            width: getScreenHeight(1),
            style: BorderStyle.solid,
            color: kSECCOLOUR,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
