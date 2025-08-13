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

  factory BagItem.fromJson(Map<String, dynamic> json) {
    return BagItem(
      productId: json['productId'],
      restaurantId: json['restaurantId'],
      restaurantName: json['restaurantName'],
      name: json['name'],
      image: json['image'],
      size: json['size'],
      price: json['price'],
      details: json['details'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'restaurantId': restaurantId,
    'restaurantName': restaurantName,
    'name': name,
    'image': image,
    'size': size,
    'price': price,
    'details': details,
    'quantity': quantity,
  };
}
