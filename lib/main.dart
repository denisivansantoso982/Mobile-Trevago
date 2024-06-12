import 'package:flutter/material.dart';
import 'package:trevago_app/constants/constant.dart';
import 'package:trevago_app/screens/dashboard_screen.dart';
import 'package:trevago_app/screens/detail_package_screen.dart';
import 'package:trevago_app/screens/detail_transport_screen.dart';
import 'package:trevago_app/screens/login_screen.dart';
import 'package:trevago_app/screens/order_package_screen.dart';
import 'package:trevago_app/screens/order_transport_screen.dart';
import 'package:trevago_app/screens/register_screen.dart';
import 'package:trevago_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travego',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColourConstant.lightBlue,
          secondary: ColourConstant.lightBlue,
        ),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
        RegisterScreen.route: (context) => const RegisterScreen(),
        DashboardScreen.route: (context) => const DashboardScreen(),
        DetailPackageScreen.route: (context) => const DetailPackageScreen(),
        OrderPackageScreen.route: (context) => const OrderPackageScreen(),
        OrderTransportScreen.route: (context) => const OrderTransportScreen(),
        DetailTransportScreen.route: (context) => const DetailTransportScreen(),
      },
    );
  }
}