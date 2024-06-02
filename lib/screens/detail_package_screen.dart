import 'package:flutter/material.dart';
import 'package:trevago_app/constants/constant.dart';
import 'package:trevago_app/screens/order_package_screen.dart';

class DetailPackageScreen extends StatefulWidget {
  const DetailPackageScreen({super.key});

  static const String route = "/detail_package";

  @override
  State<DetailPackageScreen> createState() => _DetailPackageScreenState();
}

class _DetailPackageScreenState extends State<DetailPackageScreen> {
  final List<String> _images = [
    "https://i0.wp.com/fahum.umsu.ac.id/wp-content/uploads/2024/02/Sejarah-Candi-Prambanan-serta-Fungsinya.jpg?fit=1366%2C768&ssl=1",
    "https://fatek.umsu.ac.id/wp-content/uploads/2023/06/Candi-Prambanan-Makna-Yang-Terkandung-di-Dalamnya.jpg",
    "https://d2ile4x3f22snf.cloudfront.net/wp-content/uploads/sites/210/2017/11/05101015/Candi-Prambanan.jpg",
    "https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/22/2024/02/19/candi-prambanan-496431654.jpg",
  ];

  @override
  Widget build(BuildContext context) {
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
                PageView.builder(
                  itemCount: _images.length,
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(16)),
                    child: Image(
                      image: NetworkImage(_images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 0,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder()),
                    child: const Icon(
                      Icons.chevron_left,
                      color: Colors.black,
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
                          "Wisata Candi Prambanan",
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: ColourConstant.blue,
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                "Prambanan, Klaten, Jawa Tengah",
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              "Rp. 1.200.000",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: ColourConstant.blue,
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
              "informasi Wisata",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vulputate lorem risus, sit amet faucibus metus viverra ut. In tempor urna sed elit eleifend iaculis. Sed a lectus libero. Phasellus nec posuere quam. Vivamus ut risus a dolor venenatis luctus. Proin tristique orci et risus viverra semper. Sed risus turpis.",
              style: TextStyle(
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
            Navigator.of(context).pushNamed(OrderPackageScreen.route);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColourConstant.blue,
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
