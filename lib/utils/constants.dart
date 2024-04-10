import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_colors.dart';
import 'dimensions.dart';

TextStyle kTextStyleReguler({
  Color color = kBLKCOLOUR,
  FontStyle fontStyle = FontStyle.normal,
  double fontSize = 16,
}) {
  return TextStyle(
    fontSize: getScreenHeight(fontSize),
    fontWeight: FontWeight.w400,
    fontStyle: fontStyle,
    color: color,
  );
}

TextStyle kTextStyleBold({
  Color color = kBLKCOLOUR,
  FontStyle fontStyle = FontStyle.normal,
  double fontSize = 16,
}) {
  return TextStyle(
    fontSize: getScreenHeight(fontSize),
    fontWeight: FontWeight.w700,
    fontStyle: fontStyle,
    color: color,
  );
}

TextStyle kTextStyleMedium({
  Color color = kBLKCOLOUR,
  FontStyle fontStyle = FontStyle.normal,
  double fontSize = 16,
}) {
  return TextStyle(
    fontSize: getScreenHeight(fontSize),
    fontWeight: FontWeight.w500,
    fontStyle: fontStyle,
    color: color,
  );
}

TextStyle kTextStyleSemiBold({
  Color color = kBLKCOLOUR,
  FontStyle fontStyle = FontStyle.normal,
  double fontSize = 16,
}) {
  return TextStyle(
    fontSize: getScreenHeight(fontSize),
    fontWeight: FontWeight.w600,
    fontStyle: fontStyle,
    color: color,
  );
}

TextStyle kTextStyleThin({
  Color color = kBLKCOLOUR,
  FontStyle fontStyle = FontStyle.normal,
  double fontSize = 16,
}) {
  return TextStyle(
    fontSize: getScreenHeight(fontSize),
    fontWeight: FontWeight.w100,
    fontStyle: fontStyle,
    color: color,
  );
}

TextStyle kTextStyleExtraBold({
  Color color = kBLKCOLOUR,
  FontStyle fontStyle = FontStyle.normal,
  double fontSize = 16,
}) {
  return TextStyle(
    fontSize: getScreenHeight(fontSize),
    fontWeight: FontWeight.w800,
    fontStyle: fontStyle,
    color: color,
  );
}

TextStyle kTextStyleBlack({
  Color color = kBLKCOLOUR,
  FontStyle fontStyle = FontStyle.normal,
  double fontSize = 16,
}) {
  return TextStyle(
    fontSize: getScreenHeight(fontSize),
    fontWeight: FontWeight.w900,
    fontStyle: fontStyle,
    color: color,
  );
}

TextStyle kTextStyleExtraLigt({
  Color color = kBLKCOLOUR,
  FontStyle fontStyle = FontStyle.normal,
  double fontSize = 16,
}) {
  return TextStyle(
    fontSize: getScreenHeight(fontSize),
    fontWeight: FontWeight.w200,
    fontStyle: fontStyle,
    color: color,
  );
}

TextStyle kTextStyleLight({
  Color color = kBLKCOLOUR,
  FontStyle fontStyle = FontStyle.normal,
  double fontSize = 16,
}) {
  return TextStyle(
    fontSize: getScreenHeight(fontSize),
    fontWeight: FontWeight.w300,
    fontStyle: fontStyle,
    color: color,
  );
}

TextStyle kTextStyleCustom({
  Color color = kBLKCOLOUR,
  double fontSize = 16,
  FontStyle fontStyle = FontStyle.normal,
  FontWeight fontWeight = FontWeight.w400,
}) {
  return TextStyle(
    fontSize: getScreenHeight(fontSize),
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    color: color,
  );
}

Widget yMargin(double size) {
  return SizedBox(
    height: getScreenHeight(size),
  );
}

Widget xMargin(double size) {
  return SizedBox(
    width: getScreenWidth(size),
  );
}

kToastMsgPopUp(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: kPRYCOLOUR,
    textColor: Colors.white,
    fontSize: getScreenHeight(16),
  );
}

String kHideEmail(String email) {
  // Split the email address into two parts: the username and the domain
  List<String> parts = email.split('@');
  //String username = parts[0];
  String domain = parts[1];

  // Replace the username with asterisks
  String hiddenUsername = '*' * 5;

  // Combine the hidden username and the domain
  String hiddenEmail = '$hiddenUsername@$domain';

  return hiddenEmail;
}

const kUserToken = 'user-tokens';

const kUserPassword = 'user-tokens';

const kUserEmail= 'user-tokens';