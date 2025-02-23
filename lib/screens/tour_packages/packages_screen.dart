// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/configs/api/api.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/models/tour_model.dart';
import 'package:trevago_app/models/tour_package_model.dart';
import 'package:trevago_app/screens/tour_packages/detail_package_screen.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/widgets/custom_dialog_widget.dart';
import 'package:trevago_app/widgets/tour_transparent_card_widget.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  static const String route = "/packages";

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  final TextEditingController _searchController = TextEditingController();

  static final NumberFormat formatter = NumberFormat("##,000");

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");

  Future<List<TourPackageModel>> retrieveTourPackages(
      BuildContext context) async {
    try {
      final List packages = await getTourPackages();
      final List<TourPackageModel> listPackage = [];
      for (var element in packages) {
        listPackage.add(TourPackageModel(
          id: element["id_paket"],
          title: element["nama_paket"],
          description: element["deskripsi"],
          price: element["harga"],
          tour: TourModel(
            id: element["id_wisata"],
            title: element["nama_wisata"],
            location: element["lokasi"],
            price: element["harga_tiket"],
            description: element["deskripsi_wisata"],
            image: element["gambar_wisata"],
          ),
        ));
      }
      return Future.value(listPackage
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
          "Cari Paket Wisata",
          style: TextStyleUtils.mediumDarkGray(20),
        ),
        content: SizedBox(
          child: TextField(
            controller: _searchController,
            keyboardType: TextInputType.name,
            style: TextStyleUtils.regularDarkGray(16),
            decoration: InputDecorationUtils.outlinedBlueBorder(
                "Cari Paket Wisata disini..."),
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
          "Paket Wisata",
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
      body: FutureBuilder<List<TourPackageModel>>(
        future: retrieveTourPackages(context),
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
                "Paket Wisata Tidak Ditemukan!!",
                style: TextStyleUtils.regularGray(16),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 28,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    DetailPackageScreen.route,
                    arguments: snapshot.data!.elementAt(index),
                  );
                },
                child: TourTransparentCardWidget(
                  imageUrl:
                      '${ApiConfig.tour_package_storage}/${snapshot.data!.elementAt(index).tour.image}',
                  title: snapshot.data!.elementAt(index).title,
                  location: snapshot.data!.elementAt(index).tour.location,
                  price:
                      "Rp. ${formatPrice(snapshot.data!.elementAt(index).price)}",
                ),
              );
            },
          );
        },
      ),
    );
  }
}
