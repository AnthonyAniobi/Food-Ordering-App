import 'package:flutter/material.dart';

class ProductIncrementWidget extends StatelessWidget {
  final int quantity;
  final void Function(int) onChange;

  const ProductIncrementWidget({
    super.key,
    required this.quantity,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        button(false),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            quantity.toString(),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        button(true),
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
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: const Color(0xFF101010).withAlpha(122)),
        ),
        child: Text(
          isIncrement ? '+' : '-',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
