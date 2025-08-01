import 'package:flutter/material.dart';
import 'package:food_ordering_app/home_screen/models/restaurant_model.dart';
import 'package:food_ordering_app/restaurant_detail/product_detail_screen.dart';

class ProductListWidget extends StatelessWidget {
  final ProductItem product;
  final RestaurantModel restaurant;

  const ProductListWidget({
    super.key,
    required this.product,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProductDetailScreen(
                  productItem: product,
                  restaurant: restaurant,
                );
              },
            ),
          );
        },
        child: Row(
          children: [
            Hero(
              tag: product.id,
              child: Image.asset(product.image, width: 90, height: 90),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    product.description,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Text(
              '\$${product.price}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
