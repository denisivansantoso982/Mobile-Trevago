import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/configs/api/api.dart';
import 'package:trevago_app/models/transport_model.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/screens/transports/order_transport_screen.dart';

class DetailTransportScreen extends StatefulWidget {
  const DetailTransportScreen({super.key});

  static const String route = "/detail_transport";

  @override
  State<DetailTransportScreen> createState() => _DetailTransportScreenState();
}

class _DetailTransportScreenState extends State<DetailTransportScreen> {
  static final NumberFormat formatter = NumberFormat("##,000");
  late TransportModel transport;
  late TextEditingController bookingDateController;
  late TextEditingController bookingTimeController;
  late TextEditingController bookingLocationController;
  DateTime bookingDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    bookingDateController = TextEditingController(
        text: DateFormat("dd MMMM yyyy").format(bookingDate));
    bookingTimeController =
        TextEditingController(text: DateFormat("mm:hh").format(bookingDate));
    bookingLocationController = TextEditingController();
  }

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");

  @override
  Widget build(BuildContext context) {
    transport = ModalRoute.of(context)!.settings.arguments as TransportModel;
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
          "Pemesanan Transportasi",
          style: TextStyleUtils.mediumWhite(20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 40,
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: Colors.black.withOpacity(.25),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // * Location
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: ColourUtils.darkGray,
                        size: 32,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lokasi Rental Anda",
                              style: TextStyleUtils.regularDarkGray(16),
                            ),
                            TextField(
                              controller: bookingLocationController,
                              readOnly: true,
                              style: TextStyleUtils.boldDarkGray(16),
                              onTap: () {},
                              decoration: InputDecorationUtils.noBorder(
                                "Tentukan Lokasi Penjemputan",
                                contentPadding: const EdgeInsets.only(top: 8, bottom: 4,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: ColourUtils.darkGray,
                        size: 32,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tanggal Penjemputan",
                              style: TextStyleUtils.regularDarkGray(16),
                            ),
                            TextField(
                              controller: bookingDateController,
                              readOnly: true,
                              style: TextStyleUtils.boldDarkGray(16),
                              onTap: () {},
                              decoration: InputDecorationUtils.noBorder(
                                "Tentukan Tanggal Penjemputan",
                                contentPadding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // * Time
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: ColourUtils.darkGray,
                        size: 32,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Waktu Penjemputan",
                              style: TextStyleUtils.regularDarkGray(16),
                            ),
                            TextField(
                              controller: bookingTimeController,
                              readOnly: true,
                              style: TextStyleUtils.boldDarkGray(16),
                              onTap: () {},
                              decoration: InputDecorationUtils.noBorder(
                                "Tentukan Waktu Penjemputan",
                                contentPadding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                // * Button
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyleUtils.activeButton,
                  child: Text(
                    "Pesan",
                    style: TextStyleUtils.semiboldWhite(16),
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
