// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/constants/constant.dart';
import 'package:trevago_app/screens/dashboard_screen.dart';
import 'package:trevago_app/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String route = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameTextContrroller =
      TextEditingController();
  final TextEditingController _passwordTextContrroller =
      TextEditingController();

  Future<void> handleLogin() async {
    try {
      if (validation()) {
        showDialog( // ?Loading Dialog
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
        await loginAction(
          _usernameTextContrroller.text,
          _passwordTextContrroller.text,
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
    if (_usernameTextContrroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Username harus diisi!"),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (_passwordTextContrroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password harus diisi!"),
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
            child: Icon(
              Icons.lock_sharp,
              color: Colors.black,
              size: 64,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Center(
            child: Text(
              "Welcome back you've been missed",
              style: TextStyle(
                color: ColourConstant.deepGray,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // *Username
                TextFormField(
                  controller: _usernameTextContrroller,
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
                // *Password
                TextFormField(
                  controller: _passwordTextContrroller,
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
                const SizedBox(height: 4),
                const Text(
                  "Forgot My Password?",
                  style: TextStyle(
                    color: ColourConstant.deepGray,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 64),
                // *Sign In Button
                ElevatedButton(
                  onPressed: () {
                    handleLogin();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  child: const Text(
                    "Sign In",
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
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Not a member? ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(RegisterScreen.route);
                },
                child: const Text(
                  "Register Now",
                  style: TextStyle(
                    color: ColourConstant.deepGray,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              "Skip For Now",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColourConstant.deepGray,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
