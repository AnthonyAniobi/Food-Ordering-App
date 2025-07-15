class RestaurantModel {
  final String id;
  final String name;
  final double rating;
  final String image;
  final String deliveryTime;
  final String info;
  final List<ProductItem> products;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.image,
    required this.deliveryTime,
    required this.info,
    required this.products,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    num rating = json['rating'];
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      rating: rating.toDouble(),
      image: json['image'],
      deliveryTime: json['deliveryTime'],
      info: json['infoText'],
      products:
          json['products']
              .map<ProductItem>((item) => ProductItem.fromJson(item))
              .toList(),
    );
  }
}

class ProductItem {
  final String id;
  final String image;
  final String name;
  final String description;
  final String category;
  final double price;

  ProductItem({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      price: json['price'],
    );
  }
}
