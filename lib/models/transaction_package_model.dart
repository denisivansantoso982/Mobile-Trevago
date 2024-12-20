import 'package:trevago_app/models/tour_package_model.dart';

class TransactionPackageModel {
  const  TransactionPackageModel({
    required this.id,
    required this.orderDate,
    this.admin,
    required this.note,
    required this.total,
    required this.tourPackage,
    required this.qty,
    required this.price,
    required this.subtotal,
    this.snapToken,
    this.redirectURL,
    required this.status,
    this.midtransId,
  });

  final int id;
  final DateTime orderDate;
  final int? admin;
  final String note;
  final int total;
  final TourPackageModel tourPackage;
  final int qty;
  final int price;
  final int subtotal;
  final String? snapToken;
  final String? redirectURL;
  final String status;
  final String? midtransId;
}
