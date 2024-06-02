import 'package:flutter/material.dart';
import 'package:trevago_app/constants/constant.dart';
import 'package:trevago_app/screens/dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String route = "/register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // *Username
                TextFormField(
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
                // *Alamat
                TextFormField(
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Alamat",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // *Email
                TextFormField(
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
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      DashboardScreen.route,
                      (Route<dynamic> route) => false,
                    );
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
