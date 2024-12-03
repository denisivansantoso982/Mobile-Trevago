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
          "Transportasi",
          style: TextStyleUtils.mediumWhite(20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 40,),
        child: Container(
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
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              OrderTransportScreen.route,
              arguments: transport,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColourUtils.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text(
            "Pesan Sekarang",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
