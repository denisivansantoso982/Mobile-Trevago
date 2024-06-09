// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names, constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class ApiConfig {
  // ! pastikan untuk mengubah IP ini dengan IP server
  static const String url = "http://192.168.132.193:3000/api";
  static const String tour_package_storage =
      "http://192.168.132.193:3000/storage/wisata";
  static const String transport_storage =
      "http://192.168.132.193:3000/storage/transport";

  late http.Client client;

  // ? Login
  Future<Map> login(String username, String password) async {
    try {
      client = http.Client();
      final Map body = {
        "username": username,
        "password": password,
      };
      http.Response response = await client.post(
        Uri.parse("${url}/user/login"),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
      Map result = jsonDecode(response.body);
      return Future.value(result);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Register
  Future<Map> register(
    String name,
    String email,
    String password,
    String username,
    String phone,
  ) async {
    try {
      client = http.Client();
      final Map body = {
        "nama": name,
        "email": email,
        "username": username,
        "password": password,
        "no_hp": phone,
      };
      http.Response response = await client.post(
        Uri.parse("${url}/user/register"),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      if (response.statusCode != 200 || response.statusCode != 201) {
        final Map result = jsonDecode(response.body);
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Get Profile
  Future<Map> profile(
    String token,
  ) async {
    try {
      client = http.Client();
      http.Response response = await client.get(
        Uri.parse("${url}/user/datadiri"),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
          'authorization': 'bearer $token',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map result = jsonDecode(response.body);
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Logout
  Future<void> logout(String token, String token_type) async {
    try {
      client = http.Client();
      http.Response response = await client.post(
        Uri.parse("${url}/user/logout"),
        headers: {
          'Authorization': '${token_type} ${token}',
        },
        body: {},
      );
      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)["errors"]);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Get Tour Packages
  Future<List> getListTourPackages() async {
    try {
      client = http.Client();
      http.Response response = await client.get(
        Uri.parse("${url}/user/getPaketwisata"),
      );
      if (response.statusCode == 200) {
        List result = jsonDecode(response.body);
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Get Transports
  Future<List> getListTransports() async {
    try {
      client = http.Client();
      http.Response response = await client.get(
        Uri.parse("${url}/user/getkendaraan"),
      );
      if (response.statusCode == 200) {
        List result = jsonDecode(response.body);
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Get List Transaction
  Future<List> getListTransaction(String token) async {
    try {
      client = http.Client();
      http.Response response = await client.get(
        Uri.parse("${url}/user/viewPesanan"),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
          'authorization': 'bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List result = jsonDecode(response.body)["data"];
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }


  // ? Add Transaction Tour Package
  Future<Map> addTransactionPackage(
    String token,
    DateTime order_date,
    String note,
    int package,
    int qty,
    int price,
    int subtotal,
  ) async {
    try {
      client = http.Client();
      final Map body = {
        "tgl_pesanan": order_date.toString(),
        "catatan": note,
        "id_paket": package.toString(),
        "qty": qty.toString(),
        "harga": price.toString(),
        "sub_total": subtotal.toString(),
      };
      http.Response response = await client.post(
        Uri.parse("${url}/user/createPesananWithDetails"),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
          'authorization': 'bearer $token',
        },
        body: body,
      );
      if (response.statusCode != 200 || response.statusCode != 201) {
        Map result = jsonDecode(response.body);
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }
}
