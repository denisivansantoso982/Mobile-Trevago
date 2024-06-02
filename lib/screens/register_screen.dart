// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/constants/constant.dart';
import 'package:trevago_app/screens/dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String route = "/register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameTextContrroller = TextEditingController();
  final TextEditingController _emailTextContrroller = TextEditingController();
  final TextEditingController _phoneTextContrroller = TextEditingController();
  final TextEditingController _usernameTextContrroller =
      TextEditingController();
  final TextEditingController _passwordTextContrroller =
      TextEditingController();

  Future<void> handleRegister() async {
    try {
      if (validation()) {
        showDialog(
          // ?Loading Dialog
          context: context,
          barrierDismissible: false,
          builder: (context) => const AlertDialog(
            content: SizedBox(
              width: 64,
              height: 64,
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
        );
        await registerAction(
          _nameTextContrroller.text,
          _emailTextContrroller.text,
          _passwordTextContrroller.text,
          _usernameTextContrroller.text,
          _phoneTextContrroller.text,
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
          DashboardScreen.route,
          (Route<dynamic> route) => false,
        );
      }
    } catch (error) {
      Navigator.of(context).pop(); // ?Close Loading Dialog
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
    }
  }

  bool validation() {
    if (_nameTextContrroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Nama harus diisi!"),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (_usernameTextContrroller.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Username minimal 6 karakter!"),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (_phoneTextContrroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Nomor Telepon harus diisi!"),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (_emailTextContrroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Email harus diisi!"),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (_passwordTextContrroller.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password minimal 6 karakter!"),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourConstant.lightBlue,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(40, 96, 40, 40),
        children: [
          const Center(
            child: Text(
              "CREATE ACCOUNT",
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 86,
          ),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // *Name
                TextFormField(
                  controller: _nameTextContrroller,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  keyboardType: TextInputType.name,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Nama",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // *Username
                TextFormField(
                  controller: _usernameTextContrroller,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  keyboardType: TextInputType.name,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // *Phone
                TextFormField(
                  controller: _phoneTextContrroller,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(15),
                  ],
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Nomor Telepon",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // *Email
                TextFormField(
                  controller: _emailTextContrroller,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // *Password
                TextFormField(
                  controller: _passwordTextContrroller,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // *Register Button
                ElevatedButton(
                  onPressed: () {
                    handleRegister();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
