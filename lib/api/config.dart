import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class Config {
  static String get baseUrl => 'https://stacked.com.ng/api';
}

Future<bool> checkIfIsFirstLaunch() async {
  final prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString(kUserToken);
  if (kDebugMode) {
    print(token);
  }
  if (token != null) {
    return true;
  } else {
    return false;
  }
}

Future<String?> returnEmail() async {
  final prefs = await SharedPreferences.getInstance();

  String? email = prefs.getString(kUserEmail);

  if (email == null) {
    return email;
  } else {
    return null;
  }
}

Future<String?> returnPassword() async {
  final prefs = await SharedPreferences.getInstance();

  String? password = prefs.getString(kUserPassword);

  if (password == null) {
    return password;
  } else {
    return null;
  }
}

writeUserEmail(String email) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString(kUserPassword, email);
}

writeUserPassword(String password) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString(kUserPassword, password);
}
