import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailLoader extends StatelessWidget {
  const ProductDetailLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(0xFFe0e0e0),
      highlightColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Align(
            child: Wrap(
              runSpacing: 20,
              spacing: 15,
              children: [
                Container(width: 100, height: 30, color: Colors.white),
                Container(width: 100, height: 30, color: Colors.white),
              ],
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 50, height: 30, color: Colors.white),

              Container(width: 100, height: 30, color: Colors.white),
            ],
          ),
          SizedBox(height: 30),
          Container(width: double.maxFinite, height: 30, color: Colors.white),
          SizedBox(height: 30),
          Container(width: 150, height: 30, color: Colors.white),
          SizedBox(height: 10),
          Wrap(
            runSpacing: 10,
            spacing: 15,
            children: [
              Container(width: 100, height: 30, color: Colors.white),
              Container(width: 100, height: 30, color: Colors.white),
              Container(width: 100, height: 30, color: Colors.white),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
