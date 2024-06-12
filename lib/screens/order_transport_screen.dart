// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/configs/api/api.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/constants/constant.dart';
import 'package:trevago_app/screens/dashboard_screen.dart';
import 'package:trevago_app/screens/login_screen.dart';

class OrderTransportScreen extends StatefulWidget {
  const OrderTransportScreen({super.key});

  static const String route = "/order_transport";

  @override
  State<OrderTransportScreen> createState() => _OrderTransportScreenState();
}

class _OrderTransportScreenState extends State<OrderTransportScreen> {
  static final NumberFormat formatter = NumberFormat("##,000");
  final PageController _pageController = PageController(initialPage: 0);
  final TextEditingController _dateTextController = TextEditingController();
  final TextEditingController _durationTextController =
      TextEditingController(text: "1");
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _noteTextController = TextEditingController();
  final TextEditingController _locationTextController = TextEditingController();
  late Map transport;
  late int transport_price;
  DateTime selectedDate = DateTime.now();
  int duration = 1;
  int step = 1;

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");

  @override
  void initState() {
    _dateTextController.text =
        DateFormat("EEEE, dd MMMM yyyy").format(DateTime.now());
    retrieveUserProfile(context);
    super.initState();
  }

  Future<void> retrieveUserProfile(context) async {
    try {
      final Map profile = await getProfile();
      _nameTextController.text = profile["name"];
      _phoneTextController.text = profile["phone"];
      _emailTextController.text = profile["email"];
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
    }
  }

  Future<void> submitTransaction() async {
    try {
      showDialog(
        // ? Loading Dialog
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
      await newTransactionTransport(
        _noteTextController.text,
        transport["id_kendaraan"],
        duration,
        transport_price,
        duration * transport_price,
        _locationTextController.text,
        selectedDate,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: ColourConstant.blue,
          content: Text("Transaksi Berhasil!"),
        ),
      );
      Navigator.of(context).pushNamedAndRemoveUntil(
        DashboardScreen.route,
        (route) => false,
      );
    } catch (error) {
      Navigator.of(context).pop(); // Close Loading Dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Terjadi Kesalahan!"),
          content: Text("$error"),
          actions: [
            TextButton(
              onPressed: () async {
                if (error.toString().contains("Forbidden")) {
                  await logoutAction();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.route,
                    (route) => false,
                  );
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: const Text("OKE"),
            ),
          ],
        ),
      );
    }
  }

  void handleSubmit() async {
    if (step <= 1) {
      if (duration < 1) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Isi Durasi Penyewaan!"),
          backgroundColor: Colors.black,
        ));
        return;
      } else if (_locationTextController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Isi Lokasi Penjemputan!"),
          backgroundColor: Colors.black,
        ));
        return;
      }
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        step = 2;
      });
    } else if (step <= 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        step = 3;
      });
    } else {
      submitTransaction();
    }
  }

  Future<void> selectDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
        _dateTextController.text =
            DateFormat("EEEE, dd MMMM yyyy").format(date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    transport = ModalRoute.of(context)!.settings.arguments as Map;
    transport_price = transport["harga_sewa"];
    return PopScope(
      canPop: step == 1,
      onPopInvoked: (poped) {
        if (poped) {
          return;
        }
        setState(() {
          step -= 1;
        });
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.chevron_left),
            color: ColourConstant.blue,
          ),
          title: const Text("Informasi Pemesanan"),
        ),
        body: Column(
          children: [
            Container(
              height: 96,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (step >= 1) {
                          _pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            step = 1;
                          });
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.all(12),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: step >= 1
                                  ? ColourConstant.blue
                                  : ColourConstant.darkGray,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              "1",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Expanded(
                            child: Text(
                              "Pesan",
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (step >= 2) {
                          _pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            step = 2;
                          });
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.all(12),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: step >= 2
                                  ? ColourConstant.blue
                                  : ColourConstant.darkGray,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              "2",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Expanded(
                            child: Text(
                              "Data Pemesan",
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (step >= 3) {
                          _pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            step = 3;
                          });
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.all(12),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: step >= 3
                                  ? ColourConstant.blue
                                  : ColourConstant.darkGray,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              "3",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Expanded(
                            child: Text(
                              "Pembayaran",
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // *Form 1
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.25),
                              blurRadius: 4,
                              offset: const Offset(1, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Tanggal Penyewaan",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _dateTextController,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 2,
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColourConstant.gray),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    selectDate();
                                  },
                                  icon: const Icon(Icons.calendar_month),
                                  color: ColourConstant.blue,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.25),
                              blurRadius: 4,
                              offset: const Offset(1, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Durasi Penyewaan",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Rp. ${formatPrice(transport["harga_sewa"])} / hari",
                                    style: const TextStyle(
                                      color: ColourConstant.blue,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (_durationTextController
                                        .text.isNotEmpty) {
                                      duration == 0 ? 0 : duration--;
                                    } else {
                                      duration = 0;
                                    }
                                    setState(() {
                                      _durationTextController.text =
                                          duration.toString();
                                    });
                                  },
                                  icon: const Icon(Icons.remove),
                                  color: ColourConstant.blue,
                                ),
                                SizedBox(
                                  width: 32,
                                  child: TextField(
                                    controller: _durationTextController,
                                    onChanged: (val) {
                                      setState(() {
                                        if (val.isNotEmpty) {
                                          duration = int.tryParse(val) ?? 0;
                                        } else {
                                          duration = 0;
                                        }
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(5),
                                    ],
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 2,
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColourConstant.gray),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (_durationTextController
                                        .text.isNotEmpty) {
                                      duration++;
                                    } else {
                                      duration = 1;
                                    }
                                    setState(() {
                                      _durationTextController.text =
                                          duration.toString();
                                    });
                                  },
                                  icon: const Icon(Icons.add),
                                  color: ColourConstant.blue,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.25),
                              blurRadius: 4,
                              offset: const Offset(1, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "lokasi Penjemputan",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _locationTextController,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _locationTextController.text = val;
                                });
                              },
                              keyboardType: TextInputType.streetAddress,
                              minLines: 2,
                              maxLines: 2,
                              cursorColor: ColourConstant.blue,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: "Lokasi Penjemputan",
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 12,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColourConstant.blue),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 196,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${ApiConfig.transport_storage}/${transport["gambar_kendaraan"]}"),
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.25),
                              blurRadius: 4,
                              offset: const Offset(1, 2),
                            ),
                          ],
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 16,
                          ),
                          color: Colors.white,
                          child: Text(
                            "${transport["nama_kendaraan"]} (${transport["no_kendaraan"]})",
                            softWrap: true,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // *Form 2
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    children: [
                      // *Name
                      const Text(
                        "Nama Pemesan",
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
                          hintText: "Nama Pemesan",
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
                      // *Notes
                      const Text(
                        "Catatan",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _noteTextController,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                        onChanged: (val) {
                          setState(() {
                            _noteTextController.text = val;
                          });
                        },
                        keyboardType: TextInputType.multiline,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(500),
                        ],
                        minLines: 4,
                        maxLines: 4,
                        cursorColor: ColourConstant.blue,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "Catatan (opsional)",
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
                    ],
                  ),
                  // *Form 3
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    children: [
                      const Text(
                        "Metode Pembayaran",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Image(
                          image: AssetImage("lib/assets/images/indomaret.png"),
                          height: 64,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.car_rental,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${transport["nama_kendaraan"]} (${transport["no_kendaraan"]})",
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.place,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _locationTextController.text,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat("EEE, dd MMM yyyy").format(selectedDate),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // *Divider
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black45,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Detail Pemesan",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // *Name
                      const Text(
                        "Nama Pemesan",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          _nameTextController.text,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          _phoneTextController.text,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          _emailTextController.text,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // *Notes
                      const Text(
                        "Catatan",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          _noteTextController.text,
                          softWrap: true,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // *Divider
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black45,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Detail",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Item",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Rp. ${formatPrice(transport["harga_sewa"])} / orang",
                            style: const TextStyle(
                              color: ColourConstant.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Durasi Penyewaan",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${duration.toString()} hari",
                            style: const TextStyle(
                              color: ColourConstant.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Rp. ${formatPrice(duration * transport_price)}",
                            style: const TextStyle(
                              color: ColourConstant.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: () {
              handleSubmit();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColourConstant.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              step >= 3 ? "Pesan Sekarang" : "Selanjutnya",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
