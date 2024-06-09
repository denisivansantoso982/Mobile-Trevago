// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/constants/constant.dart';
import 'package:trevago_app/screens/login_screen.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({super.key});

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();

  Future<void> handleLogout() async {
    await logoutAction();
    Navigator.of(context).pushNamedAndRemoveUntil(
      LoginScreen.route,
      (route) => false,
    );
  }

  Future<Map> retrieveUserProfile(context) async {
    try {
      final Map profile = await getProfile();
      return profile;
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Terjadi Kesalahan!"),
          content: Text("$error"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OKE"),
            ),
          ],
        ),
      );
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Profil"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        children: [
          FutureBuilder(
            future: retrieveUserProfile(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              _nameTextController.text = snapshot.data!["name"];
              _phoneTextController.text = snapshot.data!["phone"];
              _emailTextController.text = snapshot.data!["email"];
              _usernameTextController.text = snapshot.data!["username"];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // *Name
                  const Text(
                    "Nama",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _nameTextController,
                    readOnly: true,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100),
                    ],
                    cursorColor: ColourConstant.blue,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Nama",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColourConstant.blue),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // *Phone
                  const Text(
                    "Nomor Telepon",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _phoneTextController,
                    readOnly: true,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    cursorColor: ColourConstant.blue,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Nomor Telepon",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColourConstant.blue),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // *Email
                  const Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _emailTextController,
                    readOnly: true,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100),
                    ],
                    cursorColor: ColourConstant.blue,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Email",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColourConstant.blue),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // *Username
                  const Text(
                    "Username",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _usernameTextController,
                    readOnly: true,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                    cursorColor: ColourConstant.blue,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Username",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColourConstant.blue),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
          TextButton(
            onPressed: () {
              handleLogout();
            },
            child: const Text(
              "Logout",
              style: TextStyle(
                color: ColourConstant.blue,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
