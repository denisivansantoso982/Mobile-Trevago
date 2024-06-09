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
    final Map loginResponse = await api.login(username, password);
    final Map profileResponse = await api.profile(loginResponse["token"]);
    await preferences.setUserLogin(
      token: loginResponse["token"] ?? "",
      username: profileResponse["username"],
      phone: profileResponse["no_hp"] ?? "",
      name: profileResponse["nama"] ?? "",
      email: profileResponse["email"] ?? "",
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
    final Map registerResponse =
        await api.register(name, email, password, username, phone);
    return registerResponse;
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

Future<Map> getProfile() async {
  try {
    final Map userInfo = await preferences.getUserProfile();
    return Future.value(userInfo);
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> getTourPackages() async {
  try {
    final List packages = await api.getListTourPackages();
    return packages;
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> getTransports() async {
  try {
    final List transports = await api.getListTransports();
    return transports;
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> newTransactionPackage(
  DateTime order_date,
  String note,
  int package,
  int qty,
  int price,
  int subtotal,
) async {
  try {
    final Map userInfo = await preferences.getUserProfile();
    await api.addTransactionPackage(
      userInfo["token"],
      order_date,
      note,
      package,
      qty,
      price,
      subtotal,
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> getTransactions() async {
  try {
    final Map userInfo = await preferences.getUserProfile();
    final List transports = await api.getListTransaction(
      userInfo["token"],
    );
    return Future.value(transports);
  } catch (error) {
    return Future.error(error);
  }
}
