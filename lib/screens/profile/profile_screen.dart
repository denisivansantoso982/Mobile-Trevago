// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/models/users.dart';
import 'package:trevago_app/widgets/custom_dialog_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String route = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  String token = "", name = "", phone = "", email = "", username = "";

  Future<Users?> retrieveUserProfile(context) async {
    try {
      final Users profile = await getProfile();
      return profile;
    } catch (error) {
      CustomDialogWidget.showErrorDialog(context, error.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColourUtils.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Profil",
          style: TextStyleUtils.mediumWhite(20),
        ),
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
              token = snapshot.data!.token;
              _nameTextController.text =
                  snapshot.hasData ? snapshot.data!.name : "";
              _phoneTextController.text =
                  snapshot.hasData ? snapshot.data!.phone : "";
              _emailTextController.text =
                  snapshot.hasData ? snapshot.data!.email : "";
              _usernameTextController.text =
                  snapshot.hasData ? snapshot.data!.username : "";
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    cursorColor: ColourUtils.blue,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Nama",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColourUtils.blue),
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
                    cursorColor: ColourUtils.blue,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Nomor Telepon",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColourUtils.blue),
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
                    cursorColor: ColourUtils.blue,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Email",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColourUtils.blue),
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
                    cursorColor: ColourUtils.blue,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Username",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColourUtils.blue),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyleUtils.activeButton,
                    child: Text(
                      "Ubah",
                      style: TextStyleUtils.semiboldWhite(16),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
