// {
//         "id": "0",
//         "image": "assets/images/products/pizza1.png",
//         "name": "Kings Deal",
//         "description": "Any medium classic pizza + a chocolate pizza + a pet drink",
//         "category": "Combo deals",
//         "price": 20.34,
//         "size": [
//             {"Small": 20.34},
//             {"Large": 30.34},
//             {"X-Large": 40.34}
//         ],
//         "variants": [
//             "BBQ Chicken",
//             "BBQ Beef",
//             "Vegis Supreme"
//         ],
//         "drink": [
//             "Coke",
//             "Sprite",
//             "Fanta",
//             "Pepsi",
//             "Beer",
//             "Lemonade",
//             "Water"
//         ]
//     },

class ProductDetailModel {
  final String id;
  final String image;
  final String name;
  final String description;
  final String category;
  final num price;
  final List<MapEntry<String, num>> size;
  final List<String> variants;
  final List<String> drink;

  ProductDetailModel({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.size,
    required this.variants,
    required this.drink,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      price: json['price'],
      size:
          (json['size'] as List)
              .map<MapEntry<String, num>>(
                (sz) => MapEntry(sz.keys.first, sz.values.first),
              )
              .toList(),
      variants: (json['variants'] as List).map<String>((va) => va).toList(),
      drink: (json['drink'] as List).map<String>((dr) => dr).toList(),
    );
  }
}
