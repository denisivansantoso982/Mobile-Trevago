// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/models/restaurant_model.dart';
import 'package:trevago_app/screens/restaurant/detail_restaurant_screen.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/widgets/custom_dialog_widget.dart';
import 'package:trevago_app/widgets/list_restaurant_card_widget.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({super.key});

  static const String route = "/restaurants";

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  final TextEditingController _searchController = TextEditingController();

  static final NumberFormat formatter = NumberFormat("##,000");

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");

  Future<List<RestaurantModel>> retrieveRestaurants(
      BuildContext context) async {
    try {
      final List restaurants = await getRestaurants();
      final List<RestaurantModel> listRestaurant = [];
      for (var element in restaurants) {
        listRestaurant.add(RestaurantModel(
          id: element["id_rm"],
          title: element["nama_rm"],
          menu: element["menu"],
          location: element["alamat"],
          phone: element["no_tlpn"],
          price: element["harga_pax"],
          total_pax: element["jumlah_pax"],
          image: element["gambar_rm"],
          description: element["deskripsi_rm"],
        ));
      }
      return Future.value(listRestaurant
          .where((e) => e.title.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList());
    } catch (error) {
      CustomDialogWidget.showErrorDialog(context, error.toString());
      return Future.error(error);
    }
  }

  void showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Cari Kuliner",
          style: TextStyleUtils.mediumDarkGray(20),
        ),
        content: SizedBox(
          child: TextField(
            controller: _searchController,
            keyboardType: TextInputType.name,
            style: TextStyleUtils.regularDarkGray(16),
            decoration: InputDecorationUtils.outlinedBlueBorder(
                "Cari Kuliner disini..."),
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyleUtils.outlinedActiveButton,
            child: Text(
              "Batal",
              style: TextStyleUtils.mediumBlue(18),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {});
              Navigator.of(context).pop();
            },
            style: ButtonStyleUtils.activeButton,
            child: Text(
              "Cari",
              style: TextStyleUtils.mediumWhite(18),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColourUtils.blue,
        leadingWidth: 48,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
          icon: const Icon(Icons.chevron_left),
        ),
        title: Text(
          "Kuliner",
          style: TextStyleUtils.mediumWhite(24),
        ),
        actions: [
          TextButton(
            onPressed: () {
              showFilterDialog();
            },
            child: Row(
              children: [
                const Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.white,
                ),
                const SizedBox(width: 2),
                Text(
                  "Filter",
                  style: TextStyleUtils.regularWhite(18),
                ),
              ],
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<RestaurantModel>>(
        future: retrieveRestaurants(context),
        builder: (context, snapshot) {
          // print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Terjadi kesalahan!",
                    style: TextStyleUtils.mediumDarkGray(16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    snapshot.error.toString(),
                    softWrap: true,
                    style: TextStyleUtils.regularGray(14),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Kuliner Tidak Ditemukan!!",
                style: TextStyleUtils.regularGray(16),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(32),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    DetailRestaurantScreen.route,
                    arguments: snapshot.data!.elementAt(index),
                  );
                },
                child: Container(
                  height: 200,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ListRestaurantCardWidget(
                    restaurant: snapshot.data!.elementAt(index),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
