import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/bag/model/bag_item.dart';
import 'package:food_ordering_app/bag/model/bag_model.dart';
import 'package:food_ordering_app/home_screen/models/restaurant_model.dart';
import 'package:food_ordering_app/restaurant_detail/model/product_detail_model.dart';
import 'package:food_ordering_app/widgets/custom_back_button.dart';
import 'package:food_ordering_app/widgets/product_detail_loader.dart';
import 'package:food_ordering_app/widgets/product_increment_widget.dart';
import 'package:food_ordering_app/widgets/text_options_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final RestaurantModel restaurant;
  final ProductItem productItem;

  const ProductDetailScreen({
    super.key,
    required this.productItem,
    required this.restaurant,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isLoading = true;
  late ProductDetailModel productDetail;
  int sizeIndex = 0;
  String? variant;
  String? drink;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: CustomBackButton(darkBackground: true),
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          widget.productItem.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          if (!isLoading)
            Text(
              '\$${productDetail.price}',
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
            tag: widget.productItem.id,
            child: Image.asset(
              widget.productItem.image,
              width: 250,
              height: 250,
            ),
          ),
          if (isLoading)
            ProductDetailLoader()
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Align(
                  child: Wrap(
                    runSpacing: 20,
                    spacing: 15,
                    children: List.generate(productDetail.size.length, (idx) {
                      final sz = productDetail.size[idx];
                      return TextOptionsWidget(
                        text: sz.key,
                        onTap: () {
                          setState(() {
                            sizeIndex = idx;
                          });
                        },
                        selected: sizeIndex == idx,
                      );
                    }),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${(productDetail.price * quantity).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 23,
                        color: const Color(0xFFCF8600),
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    ProductIncrementWidget(
                      quantity: quantity,
                      onChange: (qnty) {
                        setState(() {
                          quantity = qnty;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  productDetail.description,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF797D82),
                  ),
                ),
                SizedBox(height: 30),
                if (productDetail.variants.isNotEmpty) ...[
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
                      ...productDetail.variants.map(
                        (vr) => TextOptionsWidget(
                          text: vr,
                          onTap: () {
                            setState(() {
                              variant = vr;
                            });
                          },
                          selected: variant == vr,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
                if (productDetail.drink.isNotEmpty) ...[
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
                      ...productDetail.drink.map(
                        (dr) => TextOptionsWidget(
                          text: dr,
                          onTap: () {
                            setState(() {
                              drink = dr;
                            });
                          },
                          selected: drink == dr,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 80),
              ],
            ),
        ],
      ),

      floatingActionButton:
          isLoading
              ? null
              : FloatingActionButton.extended(
                backgroundColor: const Color(0xFFFFA500),
                foregroundColor: Colors.white,
                onPressed: addProduct,
                label: Text('Add to Cart'),
              ),
    );
  }

  Future<void> fetchProduct() async {
    setState(() {
      isLoading = true;
    });
    final snapshot =
        await FirebaseFirestore.instance
            .collection('products')
            .doc(widget.productItem.id)
            .get();
    if (snapshot.exists) {
      productDetail = ProductDetailModel.fromJson(snapshot.data()!);
    }
    setState(() {
      isLoading = false;
    });
  }

  void addProduct() {
    final detail = [
      productDetail.size[sizeIndex].key,
      if (variant != null) variant,
      if (drink != null) drink,
    ];

    final item = BagItem(
      productId: widget.productItem.id,
      restaurantId: widget.restaurant.id,
      restaurantName: widget.restaurant.name,
      name: productDetail.name,
      image: productDetail.image,
      size: productDetail.size[sizeIndex].key,
      price: productDetail.size[sizeIndex].value.toDouble(),
      details: detail.join(', '),
      quantity: quantity,
    );

    final bag = BagModel();
    bag.addToCart(item);
    Navigator.pop(context);
  }
}
