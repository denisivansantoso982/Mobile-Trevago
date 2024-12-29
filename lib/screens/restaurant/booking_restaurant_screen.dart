// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/models/restaurant_model.dart';
import 'package:trevago_app/screens/dashboard_screen.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/widgets/custom_dialog_widget.dart';

class BookingRestaurantScreen extends StatefulWidget {
  const BookingRestaurantScreen({super.key});

  static const String route = "/booking_restaurant";

  @override
  State<BookingRestaurantScreen> createState() =>
      _BookingRestaurantScreenState();
}

class _BookingRestaurantScreenState extends State<BookingRestaurantScreen> {
  final TextEditingController _dateTextController = TextEditingController();
  final TextEditingController _participantTextController =
      TextEditingController(text: "1");
  late RestaurantModel restaurant;
  DateTime date = DateTime.now();
  int participant = 1;

  @override
  void initState() {
    super.initState();
    _dateTextController.text =
        DateFormat("dd MMMM yyyy H:mm").format(DateTime.now());
  }

  Future<void> selectDate() async {
    DateTime? selectedDate;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Pilih Waktu Reservasi",
          style: TextStyleUtils.mediumDarkGray(20),
        ),
        content: SizedBox(
          height: 200,
          child: CupertinoApp(
            debugShowCheckedModeBanner: false,
            color: Colors.white,
            theme: CupertinoThemeData(
              barBackgroundColor: Colors.white,
              brightness: Brightness.light,
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyleUtils.mediumBlue(16),
              ),
            ),
            builder: (context, child) => CupertinoDatePicker(
              dateOrder: DatePickerDateOrder.mdy,
              showDayOfWeek: false,
              use24hFormat: true,
              mode: CupertinoDatePickerMode.dateAndTime,
              minimumDate: date,
              initialDateTime: date,
              onDateTimeChanged: (date) {
                selectedDate = date;
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Batal",
              style: TextStyleUtils.mediumBlue(16),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedDate != null) {
                setState(() {
                  date = selectedDate!;
                  _dateTextController.text =
                      DateFormat("dd MMMM yyyy H:mm").format(date);
                });
              }
              Navigator.of(context).pop();
            },
            style: ButtonStyleUtils.activeButton,
            child: Text(
              "Selesai",
              style: TextStyleUtils.mediumWhite(16),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> doProcessReservation() async {
    try {
      CustomDialogWidget.showLoadingDialog(context);
      await newReservationRestaurant(restaurant.id, participant, date);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Berhasil Melakukan Reservasi!"),
        backgroundColor: ColourUtils.blue,
      ));
      Navigator.of(context)
          .popUntil(ModalRoute.withName(DashboardScreen.route));
    } catch (error) {
      Navigator.of(context).pop(); // Close Loading Dialog
      CustomDialogWidget.showErrorDialog(context, error.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dateTextController.dispose();
    _participantTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    restaurant = ModalRoute.of(context)!.settings.arguments as RestaurantModel;
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
          "Pemesanan Rumah Makan",
          style: TextStyleUtils.mediumWhite(20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: Colors.black.withAlpha(50),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // * Date
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: ColourUtils.lightGray,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tanggal Pemesanan",
                        style: TextStyleUtils.regularDarkGray(16),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _dateTextController,
                              readOnly: true,
                              style: TextStyleUtils.mediumGray(16),
                              onTap: () {
                                selectDate();
                              },
                              decoration: InputDecorationUtils.noBorder(
                                "Tentukan Tanggal Pemesanan",
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              selectDate();
                            },
                            icon: const Icon(Icons.calendar_month),
                            color: ColourUtils.gray,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // * Participant
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: Colors.black.withAlpha(50),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: ColourUtils.lightGray,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jumlah Partisipan",
                        style: TextStyleUtils.regularDarkGray(16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (_participantTextController.text.isNotEmpty) {
                                participant == 0 ? 0 : participant--;
                              } else {
                                participant = 0;
                              }
                              setState(() {
                                _participantTextController.text =
                                    participant.toString();
                              });
                            },
                            icon: const Icon(Icons.remove),
                            color: ColourUtils.blue,
                          ),
                          SizedBox(
                            width: 32,
                            child: TextField(
                              controller: _participantTextController,
                              onChanged: (val) {
                                setState(() {
                                  if (val.isNotEmpty) {
                                    participant = int.tryParse(val) ?? 0;
                                  } else {
                                    participant = 0;
                                  }
                                });
                              },
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(5),
                              ],
                              decoration:
                                  InputDecorationUtils.underlineDefaultBorder(
                                      ""),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (_participantTextController.text.isNotEmpty) {
                                participant++;
                              } else {
                                participant = 1;
                              }
                              setState(() {
                                _participantTextController.text =
                                    participant.toString();
                              });
                            },
                            icon: const Icon(Icons.add),
                            color: ColourUtils.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
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
            doProcessReservation();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColourUtils.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            "Pesan Sekarang",
            style: TextStyleUtils.semiboldWhite(16),
          ),
        ),
      ),
    );
  }
}
