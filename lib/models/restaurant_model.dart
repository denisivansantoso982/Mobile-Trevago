class RestaurantModel {
  const RestaurantModel({
    required this.id,
    required this.title,
    required this.menu,
    required this.location,
    required this.phone,
    required this.price,
  });

  final int id;
  final String title;
  final String menu;
  final String location;
  final String phone;
  final String price;
}
