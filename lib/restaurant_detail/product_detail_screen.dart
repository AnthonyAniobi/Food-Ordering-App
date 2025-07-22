import 'package:flutter/material.dart';
import 'package:food_ordering_app/home_screen/models/restaurant_model.dart';
import 'package:food_ordering_app/widgets/custom_back_button.dart';
import 'package:food_ordering_app/widgets/product_increment_widget.dart';
import 'package:food_ordering_app/widgets/text_options_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductItem productItem;

  const ProductDetailScreen({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: CustomBackButton(darkBackground: true),
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          productItem.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          Text(
            '\$${productItem.price}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFCF8600),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Hero(
            tag: productItem.id,
            child: Image.asset(productItem.image, width: 250, height: 250),
          ),
          SizedBox(height: 20),
          Align(
            child: Wrap(
              runSpacing: 20,
              spacing: 15,
              children: [
                TextOptionsWidget(
                  text: 'X-large',
                  onTap: () {},
                  selected: true,
                ),
                TextOptionsWidget(
                  text: 'X-large',
                  onTap: () {},
                  selected: false,
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${productItem.price}',
                style: TextStyle(
                  fontSize: 23,
                  color: const Color(0xFFCF8600),
                  fontWeight: FontWeight.bold,
                ),
              ),

              ProductIncrementWidget(quantity: 1, onChange: (qnty) {}),
            ],
          ),
          SizedBox(height: 30),
          Text(
            productItem.description,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF797D82),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Select Variant',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF797D82),
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            runSpacing: 10,
            spacing: 15,
            children: [
              TextOptionsWidget(
                text: 'BBQ Chicken',
                onTap: () {},
                selected: false,
              ),
              TextOptionsWidget(
                text: 'BBQ Chicken',
                onTap: () {},
                selected: false,
              ),
              TextOptionsWidget(
                text: 'BBQ Chicken',
                onTap: () {},
                selected: false,
              ),
            ],
          ),
          SizedBox(height: 30),
          Text(
            'Select pet drink',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF797D82),
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            runSpacing: 10,
            spacing: 15,
            children: [
              TextOptionsWidget(
                text: 'BBQ Chicken',
                onTap: () {},
                selected: false,
              ),
              TextOptionsWidget(
                text: 'BBQ Chicken',
                onTap: () {},
                selected: false,
              ),
              TextOptionsWidget(
                text: 'BBQ Chicken',
                onTap: () {},
                selected: false,
              ),
            ],
          ),
          SizedBox(height: 80),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFFFA500),
        foregroundColor: Colors.white,
        onPressed: () {},
        label: Text('Add to Cart'),
      ),
    );
  }
}
