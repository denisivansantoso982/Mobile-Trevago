import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourConstant.lightBlue,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(40, 96, 40, 40),
        children: [
          const Center(
            child: Icon(Icons.lock_sharp, color: Colors.black, size: 64,),
          ),
          const SizedBox(height: 24,),
          const Center(
            child: Text("Welcome back you've been missed", style: TextStyle(color: ColourConstant.deepGray, fontSize: 14, fontWeight: FontWeight.w400,),),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  color: ColourConstant.deepGray,
                  height: 1,
                  margin: const EdgeInsets.only(right: 4),
                ),
              ),
              const Text(
                "Or continue with",
                style: TextStyle(
                  color: ColourConstant.deepGray,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: Container(
                  color: ColourConstant.deepGray,
                  height: 1,
                  margin: const EdgeInsets.only(left: 4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // *Google Button
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 64,
                  width: 64,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Image(image: AssetImage("lib/assets/images/google.png")),
                ),
              ),
              const SizedBox(width: 24),
              // *Apple Button
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 64,
                  width: 64,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Image(
                      image: AssetImage("lib/assets/images/apple.png")),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
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
          const SizedBox(height: 24,),
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
