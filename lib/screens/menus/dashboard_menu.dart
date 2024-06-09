// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:trevago_app/configs/api/api.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/constants/constant.dart';
import 'package:trevago_app/screens/detail_package_screen.dart';
import 'package:intl/intl.dart';

class DashboardMenu extends StatelessWidget {
  const DashboardMenu({super.key});

  static final NumberFormat formatter = NumberFormat("##,000");

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");

  Future<List> retrieveTourPackages(BuildContext context) async {
    try {
      final List packages = await getTourPackages();
      return packages;
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
      return [];
    }
  }

  Future<List> retrieveTransports(BuildContext context) async {
    try {
      final List packages = await getTransports();
      return packages;
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
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 56),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Hari ini kamu mau",
                style: TextStyle(
                  color: ColourConstant.deepGray,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    "pergi ",
                    style: TextStyle(
                      color: ColourConstant.lightBlue,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "ke mana?",
                    style: TextStyle(
                      color: ColourConstant.deepGray,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // *Menu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // *Hotel
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: ColourConstant.lightBlue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.business_outlined,
                            color: Colors.black,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Hotel",
                          style: TextStyle(
                            color: ColourConstant.deepGray.withOpacity(.73),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // *Car
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: ColourConstant.lightBlue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.car_rental_outlined,
                            color: Colors.black,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Transport",
                          style: TextStyle(
                            color: ColourConstant.deepGray.withOpacity(.73),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // *Restaurant
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: ColourConstant.lightBlue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.food_bank_outlined,
                            color: Colors.black,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Restoran",
                          style: TextStyle(
                            color: ColourConstant.deepGray.withOpacity(.73),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // *Tour Packages
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: ColourConstant.lightBlue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.airplane_ticket_outlined,
                            color: Colors.black,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Paket Wisata",
                          style: TextStyle(
                            color: ColourConstant.deepGray.withOpacity(.73),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // *Wisata Populer
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Wisata Populer",
                style: TextStyle(
                  color: ColourConstant.darkGray,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Rekomendasi Wisata",
                    style: TextStyle(
                      color: ColourConstant.deepGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "View All",
                      style: TextStyle(
                        color: ColourConstant.violet,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 240,
              child: FutureBuilder(
                future: retrieveTourPackages(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: !snapshot.hasData ? 0 : snapshot.data!.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          DetailPackageScreen.route,
                          arguments: snapshot.data!.elementAt(index),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.only(bottom: 12),
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: Image(
                                image: NetworkImage(
                                  '${ApiConfig.tour_package_storage}/${snapshot.data!.elementAt(index)["gambar_wisata"]!}',
                                ),
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                snapshot.data!.elementAt(index)["nama_paket"],
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 2,
                                style: const TextStyle(
                                  color: ColourConstant.darkGray,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                "Rp. ${formatPrice(snapshot.data!.elementAt(index)["harga"])}",
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: const TextStyle(
                                  color: ColourConstant.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // const SizedBox(height: 32),
            // *Destinasi populer
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: Text(
            //     "Destinasi populer di Yogyakarta",
            //     style: TextStyle(
            //       color: ColourConstant.darkGray,
            //       fontSize: 18,
            //       fontWeight: FontWeight.w700,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 12),
            // SizedBox(
            //   height: 256,
            //   child: ListView.builder(
            //     padding: const EdgeInsets.symmetric(horizontal: 8),
            //     scrollDirection: Axis.horizontal,
            //     itemCount: 10,
            //     itemBuilder: (context, index) => GestureDetector(
            //       onTap: () {
            //         Navigator.of(context).pushNamed(DetailPackageScreen.route);
            //       },
            //       child: Container(
            //         margin: const EdgeInsets.symmetric(
            //           horizontal: 8,
            //           vertical: 4,
            //         ),
            //         padding: const EdgeInsets.only(bottom: 8),
            //         width: 164,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(12),
            //           color: Colors.white,
            //           boxShadow: [
            //             BoxShadow(
            //               color: Colors.black.withOpacity(.25),
            //               offset: const Offset(1, 2),
            //               blurRadius: 4,
            //             ),
            //           ],
            //         ),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.stretch,
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             ClipRRect(
            //               borderRadius: BorderRadius.circular(12),
            //               child: Image(
            //                 image: NetworkImage(popularTour["image"]!),
            //                 height: 138,
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
            //             Flexible(
            //               child: Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 4),
            //                 child: Text(
            //                   popularTour["name"]!,
            //                   softWrap: false,
            //                   overflow: TextOverflow.fade,
            //                   style: const TextStyle(
            //                     color: ColourConstant.darkGray,
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             Flexible(
            //               child: Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 4),
            //                 child: Row(
            //                   children: [
            //                     const Icon(
            //                       Icons.place,
            //                       color: Colors.black,
            //                       size: 10,
            //                     ),
            //                     const SizedBox(width: 4),
            //                     Expanded(
            //                       child: Text(
            //                         popularTour["location"]!,
            //                         overflow: TextOverflow.fade,
            //                         softWrap: false,
            //                         style: const TextStyle(
            //                           color: ColourConstant.darkGray,
            //                           fontSize: 14,
            //                           fontWeight: FontWeight.w400,
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             Flexible(
            //               child: Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 4),
            //                 child: Text(
            //                   "Rp. ${formatPrice(popularTour['price']!)}",
            //                   overflow: TextOverflow.fade,
            //                   style: const TextStyle(
            //                     color: ColourConstant.blue,
            //                     fontSize: 18,
            //                     fontWeight: FontWeight.w700,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // *Car
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Transport",
                    style: TextStyle(
                      color: ColourConstant.deepGray,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "see All",
                      style: TextStyle(
                        color: ColourConstant.purple,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            FutureBuilder(
              future: retrieveTransports(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: !snapshot.hasData ? 0 : snapshot.data!.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        height: 84,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.25),
                              blurRadius: 4,
                              offset: const Offset(.5, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image(
                                image: NetworkImage(
                                    '${ApiConfig.transport_storage}/${snapshot.data!.elementAt(index)["gambar_kendaraan"]!}'),
                                height: 84,
                                width: 84,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    snapshot.data!
                                        .elementAt(index)["nama_kendaraan"]!,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Rp. ${formatPrice(snapshot.data!.elementAt(index)["harga_sewa"])}",
                                        style: const TextStyle(
                                          color: ColourConstant.purple,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const Text(
                                        " / hari",
                                        style: TextStyle(
                                          color: ColourConstant.gray,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
