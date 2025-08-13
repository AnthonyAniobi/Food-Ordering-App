import 'package:flutter/material.dart';
import 'package:food_ordering_app/bag/checkout_screen.dart';
import 'package:food_ordering_app/bag/model/bag_model.dart';
import 'package:food_ordering_app/widgets/bag_item_widget.dart';
import 'package:food_ordering_app/widgets/primary_button.dart';

class BagScreen extends StatefulWidget {
  const BagScreen({super.key});

  @override
  State<BagScreen> createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  @override
  Widget build(BuildContext context) {
    BagModel bag = BagModel();
    final bagGroup = bag.groupedList.entries.toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'My Bag',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body:
          bagGroup.isEmpty
              ? Center(child: Text('Bag is Empty'))
              : ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  ...bagGroup.map((bagItem) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          bagItem.key,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withAlpha(150),
                          ),
                        ),
                        SizedBox(height: 10),
                        ...bagItem.value.map(
                          (bg) => BagItemWidget(
                            quantity: bg.quantity,
                            onChange: (v) {
                              bag.updateQuantity(bg.productId, bg.details, v);
                              setState(() {});
                            },
                            onDelete: () {
                              bag.removeItem(bg.productId, bg.details);
                              setState(() {});
                            },
                            item: bg,
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: 10),
                  informationRow(
                    'Subtotal',
                    '\$${bag.totalPrice.toStringAsFixed(2)}',
                  ),
                  SizedBox(height: 10),
                  informationRow('Delivery', '\$12'),
                  SizedBox(height: 10),
                  informationRow(
                    'Total',
                    '\$${bag.totalPrice.toStringAsFixed(2)}',
                    isBold: true,
                  ),
                  SizedBox(height: 10),
                  PrimaryButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CheckoutScreen();
                          },
                        ),
                      );
                    },
                    text: 'Checkout',
                  ),
                  SizedBox(height: 100),
                ],
              ),
    );
  }

  Widget informationRow(String info, String text, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          info,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w400,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
