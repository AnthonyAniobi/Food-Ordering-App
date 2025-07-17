import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ordering_app/constants/app_images.dart';
import 'package:food_ordering_app/home_screen/models/restaurant_model.dart';
import 'package:food_ordering_app/home_screen/widgets/home_screen_loader.dart';
import 'package:food_ordering_app/home_screen/widgets/restaurant_card.dart';
import 'package:food_ordering_app/widgets/primary_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RestaurantModel> restaurants = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deliver to:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '08776 Serenity Ports, New York',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF797D82),
                            ),
                          ),
                          SizedBox(width: 10),
                          SvgPicture.asset(
                            AppSvg.arrowDown,
                            colorFilter: ColorFilter.mode(
                              const Color(0xFF797D82),
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 51,
                  height: 51,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: const Color(0x7FCF8600),
                  ),
                  child: SvgPicture.asset(
                    AppSvg.profileInactive,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                isDense: true,
                constraints: BoxConstraints(minHeight: 61, maxHeight: 61),
                prefixIcon: Container(
                  margin: EdgeInsets.only(left: 20, right: 16),
                  width: 24,
                  child: SvgPicture.asset(
                    AppSvg.searchNormal,
                    width: 24,
                    height: 24,
                  ),
                ),
                hintText: 'Search for a vendor or product',
                hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                filled: true,
                fillColor: const Color(0xFF101010).withAlpha(25),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),

            SizedBox(height: 40),

            if (isLoading)
              HomeScreenLoader()
            else
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Restaurants',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF797D82),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  ...restaurants.map(
                    (rest) => RestaurantCard(restaurant: rest),
                  ),

                  SizedBox(height: 20),

                  PrimaryButton(onTap: () {}, text: 'View all restaurants'),
                ],
              ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> fetchRestaurants() async {
    // get all restuarants
    await Future.delayed(const Duration(seconds: 2));
    final snapshot =
        await FirebaseFirestore.instance.collection('restaurants').get();
    final restaurantList =
        snapshot.docs.map((dt) => RestaurantModel.fromJson(dt.data())).toList();
    restaurants = restaurantList;
    setState(() {
      isLoading = false;
    });
  }
}
