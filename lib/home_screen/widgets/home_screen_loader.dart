import 'package:flutter/material.dart';
import 'package:food_ordering_app/home_screen/widgets/restaurant_card.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenLoader extends StatelessWidget {
  const HomeScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Shimmer.fromColors(
              baseColor: Color(0xFFe0e0e0),
              highlightColor: Colors.white,
              child: Container(width: 200, height: 17, color: Colors.white),
            ),

            Shimmer.fromColors(
              baseColor: Color(0xFFe0e0e0),
              highlightColor: Colors.white,
              child: Container(width: 50, height: 17, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 20),

        restaurantCardShimmer(),
        restaurantCardShimmer(),
        restaurantCardShimmer(),
      ],
    );
  }

  Widget restaurantCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Color(0xFFe0e0e0),
      highlightColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 210,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 15,
                  child: ClipPath(
                    clipper: CustomCardClipper(),
                    child: Container(color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(width: 200, height: 30, color: Colors.white),
          SizedBox(height: 10),
          Row(
            children: [
              Container(width: 100, height: 15, color: Colors.white),
              const Spacer(),
              Container(width: 50, height: 15, color: Colors.white),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
