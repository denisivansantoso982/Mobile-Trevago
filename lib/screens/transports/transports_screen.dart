import 'package:flutter/material.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/models/transport_model.dart';
import 'package:trevago_app/screens/transports/detail_transport_screen.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/widgets/list_transport_card_widget.dart';

class TransportsScreen extends StatefulWidget {
  const TransportsScreen({super.key});

  static const String route = "/transports";

  @override
  State<TransportsScreen> createState() => _TransportsScreenState();
}

class _TransportsScreenState extends State<TransportsScreen> {
  final TextEditingController _searchController = TextEditingController();

  Future<List<TransportModel>> retrieveTransports() async {
    try {
      final List transports = await getTransports();
      final List<TransportModel> listTransport = [];
      for (var element in transports) {
        listTransport.add(
          TransportModel(
            id: element["id_kendaraan"],
            type: element["tipe_kendaraan"],
            transportNumber: element["no_kendaraan"],
            seatCount: element["jumlah_seat"],
            price: element["harga_sewa"],
            name: element["nama_kendaraan"],
            image: element["gambar_kendaraan"],
          ),
        );
      }
      return Future.value(listTransport.where((e) => e.name.toLowerCase().contains(_searchController.text.toLowerCase())).toList());
    } catch (error) {
      return Future.error(error);
    }
  }

  void showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Cari Transportasi",
          style: TextStyleUtils.mediumDarkGray(20),
        ),
        content: SizedBox(
          child: TextField(
            controller: _searchController,
            keyboardType: TextInputType.name,
            style: TextStyleUtils.regularDarkGray(16),
            decoration: InputDecorationUtils.outlinedBlueBorder(
                "Cari transportasi disini..."),
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
    super.dispose();
    _searchController.dispose();
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
          "Transportasi",
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
      body: FutureBuilder<List<TransportModel>>(
        future: retrieveTransports(),
        builder: (context, snapshot) {
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
                "Transportasi Tidak Ditemukan!!",
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
                    DetailTransportScreen.route,
                    arguments: snapshot.data![index],
                  );
                },
                child: ListTransportCardWidget(
                  transport: snapshot.data![index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
