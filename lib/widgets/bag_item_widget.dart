import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/bag/model/bag_item.dart';

class BagItemWidget extends StatelessWidget {
  final BagItem item;
  final Function(int) onChange;
  final Function() onDelete;
  final int quantity;

  const BagItemWidget({
    super.key,
    required this.item,
    required this.onChange,
    required this.onDelete,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Image.asset(item.image, width: 80, height: 80),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Product name',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onDelete,
                        icon: Icon(Icons.close),
                        iconSize: 14,
                      ),
                    ],
                  ),
                  Text(
                    item.details,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF101010).withAlpha(80),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '\$${item.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF101010),
                          ),
                        ),
                      ),
                      button(false),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          quantity.toString(),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      button(true),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        DottedLine(dashColor: Color(0xFF101010).withAlpha(60)),
      ],
    );
  }

  Widget button(bool isIncrement) {
    return InkWell(
      onTap: () {
        if (isIncrement) {
          onChange(quantity + 1);
        } else if (quantity <= 1) {
          return;
        } else {
          onChange(quantity - 1);
        }
      },
      child: Container(
        width: 20,
        height: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: const Color(0xFF101010).withAlpha(60),
        ),
        child: Text(
          isIncrement ? '+' : '-',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
