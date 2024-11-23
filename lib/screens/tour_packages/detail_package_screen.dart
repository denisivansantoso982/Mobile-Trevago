import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/configs/api/api.dart';
import 'package:trevago_app/models/tour_package_model.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/screens/tour_packages/order_package_screen.dart';

class DetailPackageScreen extends StatefulWidget {
  const DetailPackageScreen({super.key});

  static const String route = "/detail_package";

  @override
  State<DetailPackageScreen> createState() => _DetailPackageScreenState();
}

class _DetailPackageScreenState extends State<DetailPackageScreen> {
  static final NumberFormat formatter = NumberFormat("##,000");
  late TourPackageModel package;

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");

  @override
  Widget build(BuildContext context) {
    package = ModalRoute.of(context)!.settings.arguments as TourPackageModel;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: [
          // *Images
          SizedBox(
            height: 300,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(16)),
                  child: Image(
                    image: NetworkImage(
                        "${ApiConfig.tour_package_storage}/${package.tour.image}"),
                    fit: BoxFit.cover,
                  ),
                ),
                // PageView.builder(
                //   itemCount: _images.length,
                //   itemBuilder: (context, index) => ClipRRect(
                //     borderRadius: const BorderRadius.vertical(
                //         bottom: Radius.circular(16)),
                //     child: Image(
                //       image: NetworkImage(_images[index]),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                Positioned(
                  top: 4,
                  left: 0,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(.8),
                        shape: const CircleBorder()),
                    child: const Icon(
                      Icons.chevron_left,
                      color: ColourUtils.blue,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 0,
                  child: Container(
                    width: screenWidth - 24,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(1, 1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          package.title,
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: ColourUtils.blue,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                package.tour.location,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "Rp. ${formatPrice(package.price)}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: ColourUtils.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Informasi Wisata",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              package.description,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(OrderPackageScreen.route, arguments: package,);
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