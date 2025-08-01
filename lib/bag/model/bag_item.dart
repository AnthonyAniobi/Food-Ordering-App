class BagItem {
  final String productId;
  final String restaurantId;
  final String restaurantName;
  final String name;
  final String image;
  final String size;
  final double price;
  final String details;
  int quantity;

  double get totalPrice => quantity * price;

  BagItem({
    required this.productId,
    required this.restaurantId,
    required this.restaurantName,
    required this.name,
    required this.image,
    required this.size,
    required this.price,
    required this.details,
    this.quantity = 1,
  });
}
