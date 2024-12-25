// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/configs/api/api.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/models/tour_model.dart';
import 'package:trevago_app/screens/tours/detail_tour_screen.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/widgets/custom_dialog_widget.dart';
import 'package:trevago_app/widgets/list_tour_card_widget.dart';

class ToursScreen extends StatefulWidget {
  const ToursScreen({super.key});

  static const String route = "/tours";

  @override
  State<ToursScreen> createState() => _ToursScreenState();
}

class _ToursScreenState extends State<ToursScreen> {
  final TextEditingController _searchController = TextEditingController();

  static final NumberFormat formatter = NumberFormat("##,000");

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");

  Future<List<TourModel>> retrieveTours(BuildContext context) async {
    try {
      final List tours = await getTours();
      final List<TourModel> listTour = [];
      for (var element in tours) {
        listTour.add(TourModel(
          id: element["id_wisata"],
          title: element["nama_wisata"],
          location: element["lokasi"],
          price: element["harga_tiket"],
          description: element["deskripsi_wisata"],
          image: element["gambar_wisata"],
        ));
      }
      return Future.value(listTour.where((e) => e.title.toLowerCase().contains(_searchController.text.toLowerCase())).toList());
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
          "Cari Tempat Wisata",
          style: TextStyleUtils.mediumDarkGray(20),
        ),
        content: SizedBox(
          child: TextField(
            controller: _searchController,
            keyboardType: TextInputType.name,
            style: TextStyleUtils.regularDarkGray(16),
            decoration: InputDecorationUtils.outlinedBlueBorder("Cari wisatamu disini..."),
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
          "Wisata",
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
      body: FutureBuilder<List<TourModel>>(
        future: retrieveTours(context),
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
                "Wisata Tidak Ditemukan!!",
                style: TextStyleUtils.regularGray(16),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    DetailTourScreen.route,
                    arguments: snapshot.data!.elementAt(index),
                  );
                },
                child: Container(
                  height: 200,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ListTourCardWidget(
                    imageUrl:
                        '${ApiConfig.tour_package_storage}/${snapshot.data!.elementAt(index).image}',
                    title: snapshot.data!.elementAt(index).title,
                    location: snapshot.data!.elementAt(index).location,
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
