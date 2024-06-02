import 'package:flutter/material.dart';
import 'package:trevago_app/constants/constant.dart';
import 'package:trevago_app/screens/menus/dashboard_menu.dart';
import 'package:trevago_app/screens/menus/ordered_menu.dart';
import 'package:trevago_app/screens/menus/profile_menu.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const String route = "/dashboard";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  Widget loadContent() {
    if (currentIndex == 0) {
      return const DashboardMenu();
    } else if (currentIndex == 1) {
      return const Center(
        child: OrderedMenu(),
      );
    }
    return const Center(
      child: ProfileMenu(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loadContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        elevation: 16,
        selectedLabelStyle: const TextStyle(
          color: ColourConstant.lightBlue,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        unselectedLabelStyle: const TextStyle(
          color: ColourConstant.lightBlue,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list),
            label: "Pesanan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
