// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/configs/api/api.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/models/reservation_restaurant_model.dart';
import 'package:trevago_app/models/restaurant_model.dart';
import 'package:trevago_app/screens/restaurant/detail_reservation_restaurant_screen.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/widgets/custom_dialog_widget.dart';

class ReservationRestaurantScreen extends StatefulWidget {
  const ReservationRestaurantScreen({super.key});

  static const String route = "/resevation_restaurant";

  @override
  State<ReservationRestaurantScreen> createState() =>
      _ReservationRestaurantScreenState();
}

class _ReservationRestaurantScreenState
    extends State<ReservationRestaurantScreen> {
  Future<List<ReservationRestaurantModel>> retrieveReservationRestaurant() async {
    try {
      final List reservationRestaurant = await getReservationRestaurant();
      final List<ReservationRestaurantModel> result = [];
      for (var element in reservationRestaurant) {
        result.add(ReservationRestaurantModel(
          id: element["id"],
          orderDate: DateTime.parse(element["waktu_reservasi"]),
          totalPax: element["jumlah_pax"],
          restaurant: RestaurantModel(
            id: element["id_rm"],
            title: element["nama_rm"],
            menu: element["menu"],
            location: element["alamat"],
            phone: element["no_tlpn"],
            price: element["harga_pax"],
            total_pax: element["jumlah_pax"],
            image: element["gambar_rm"],
            description: element["deskripsi_rm"],
          ),
        ));
      }
      return result;
    } catch (error) {
      CustomDialogWidget.showErrorDialog(context, error.toString());
      return [];
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
          "Reservasi Restoran",
          style: TextStyleUtils.mediumWhite(20),
        ),
      ),
      body: FutureBuilder(
        future: retrieveReservationRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  DetailReservationRestaurantScreen.route,
                  arguments: snapshot.data![index],
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: .5,
                    color: Colors.black38,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 4,
                      offset: const Offset(.5, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        snapshot.data![index].restaurant.title,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: ColourUtils.darkGray,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      height: 96,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage("${ApiConfig.restaurant_storage}/${snapshot.data![index].restaurant.image}",), fit: BoxFit.cover,)
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              DateFormat("E, dd MMM yyyy - HH:mm").format(snapshot.data![index].orderDate),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: ColourUtils.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
