import 'package:flutter/material.dart';
import 'package:trevago_app/constants/constant.dart';
import 'package:trevago_app/screens/detail_package_screen.dart';
import 'package:intl/intl.dart';

class DashboardMenu extends StatelessWidget {
  const DashboardMenu({super.key});

  static final NumberFormat formatter = NumberFormat("##,000");

  static Map<String, String> tour = {
    "image":
        "https://images.tokopedia.net/img/KRMmCm/2022/6/16/56b7b2bc-aeab-4fe9-bb3b-b97ce6ccef67.jpg",
    "name": "Tugu Yogya",
    "location": "Yogyakarta",
  };
  static Map<String, dynamic> popularTour = {
    "image":
        "https://asset.kompas.com/crops/G6nRAO-qBgTMYJTwr4-KSieBnW0=/1x5:677x455/750x500/data/photo/2023/09/25/65119e9ac2bb8.jpg",
    "name": "Candi Prambanan",
    "location": "Prambanan, Klaten, Jawa Tengah",
    "price": 1200000,
  };

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");

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
                          "Car",
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
                          "Restaurant",
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
                          "Tour Packages",
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
              height: 200,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(DetailPackageScreen.route);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image(
                            image: NetworkImage(tour["image"]!),
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          tour["name"]!,
                          style: const TextStyle(
                            color: ColourConstant.darkGray,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          tour["location"]!,
                          style: const TextStyle(
                            color: ColourConstant.darkGray,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // *Destinasi populer
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Destinasi populer di Yogyakarta",
                style: TextStyle(
                  color: ColourConstant.darkGray,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 256,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(DetailPackageScreen.route);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4,),
                    padding: const EdgeInsets.only(bottom: 8),
                    width: 164,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.25),
                          offset: const Offset(1, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image(
                            image: NetworkImage(popularTour["image"]!),
                            height: 138,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              popularTour["name"]!,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                color: ColourConstant.darkGray,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.place,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    popularTour["location"]!,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: const TextStyle(
                                      color: ColourConstant.darkGray,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              "Rp. ${formatPrice(popularTour['price']!)}",
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                color: ColourConstant.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
            ListView(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(DetailPackageScreen.route);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    height: 84,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: const Image(
                            image: NetworkImage(
                                "https://cf.bstatic.com/xdata/images/hotel/max1024x768/210164636.jpg?k=abaeb4e01c4076157b12bf0ebb0dd10bd5ab1aa56e25540fc183b27a48828000&o=&hp=1"),
                            height: 84,
                            width: 84,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Diana Hotel",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Sleman, Yogyakarta",
                                style: TextStyle(
                                  color: ColourConstant.gray,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Rp. 200.000",
                                    style: TextStyle(
                                      color: ColourConstant.purple,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    " / malam",
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
                        const Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: ColourConstant.yellow,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "5.0",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(DetailPackageScreen.route);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    height: 84,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: const Image(
                            image: NetworkImage(
                                "https://cf.bstatic.com/xdata/images/hotel/max1024x768/210164636.jpg?k=abaeb4e01c4076157b12bf0ebb0dd10bd5ab1aa56e25540fc183b27a48828000&o=&hp=1"),
                            height: 84,
                            width: 84,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Diana Hotel",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Sleman, Yogyakarta",
                                style: TextStyle(
                                  color: ColourConstant.gray,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Rp. 200.000",
                                    style: TextStyle(
                                      color: ColourConstant.purple,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    " / malam",
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
                        const Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: ColourConstant.yellow,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "5.0",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
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
          ],
        ),
      ),
    );
  }
}
