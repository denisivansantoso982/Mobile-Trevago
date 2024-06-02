// ignore_for_file: non_constant_identifier_names

import 'package:flutter/services.dart';
import 'package:trevago_app/configs/api/api.dart';
import 'package:trevago_app/configs/preferences/preferences.dart';

Preferences preferences = Preferences();
ApiConfig api = ApiConfig();

Future<Map> getExistingUser() async {
  final Map userInfo = await preferences.getUserProfile();
  return userInfo;
}

Future<Map> loginAction(
  String username,
  String password,
) async {
  try {
    final Map response = await api.login(username, password);
    await preferences.setUserLogin(
      token: response["token"] ?? "",
      username: username,
      phone: response["phone"] ?? "",
      name: response["name"] ?? "",
      email: response["email"] ?? "",
    );
    final Map userInfo = await preferences.getUserProfile();
    if (userInfo["token"].isEmpty) {
      throw "Credentials not match";
    }
    return userInfo;
  } catch (error) {
    return Future.error(error);
  }
}

Future<Map> registerAction(
  String name,
  String email,
  String password,
  String username,
  String phone,
) async {
  try {
    final Map response =
        await api.register(name, email, password, username, phone);
    await preferences.setUserLogin(
      token: response["token"],
      username: username,
      phone: phone,
      name: name,
      email: email,
    );
    final Map userInfo = await preferences.getUserProfile();
    if (userInfo["token"].isEmpty) {
      throw "Credentials not match";
    }
    return userInfo;
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> logoutAction() async {
  try {
    await preferences.deleteUser();
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> getCities() async {
  try {
    final Map userInfo = await preferences.getUserProfile();
    final List cities = await api.getListCities(
      userInfo["token"],
      userInfo["token_type"],
    );
    return cities;
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> getCustomersOutlets() async {
  try {
    final Map userInfo = await preferences.getUserProfile();
    final List cities = await api.getOutlets(
      userInfo["token"],
      userInfo["token_type"],
    );
    return cities;
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> addNewOutlet(
  String outlet_name,
  String phone,
  String address,
  String city,
  String postal_code,
  Uint8List photo,
  String name,
) async {
  try {
    final Map userInfo = await preferences.getUserProfile();
    await api.addNewCustomerOutlet(
      outlet_name,
      phone,
      address,
      postal_code,
      city,
      photo,
      name,
      userInfo["token"],
      userInfo["token_type"],
    );
  } catch (error) {
    return Future.error(error);
  }
}
