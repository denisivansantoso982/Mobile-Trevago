// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  late SharedPreferences prefs;

  Future<void> setUserLogin({
    required String name,
    required String email,
    required String username,
    required String phone,
    required String token,
  }) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("name", name);
    prefs.setString("email", email);
    prefs.setString("username", username);
    prefs.setString("phone", phone);
    prefs.setString("token", token);
  }

  Future<Map> getUserProfile() async {
    prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name") ?? "";
    String token = prefs.getString("token") ?? "";
    String email = prefs.getString("email") ?? "";
    String phone = prefs.getString("phone") ?? "";
    String username = prefs.getString("username") ?? "";
    return {
      "name": name,
      "token": token,
      "email": email,
      "username": username,
      "phone": phone,
    };
  }

  Future<void> deleteUser() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
