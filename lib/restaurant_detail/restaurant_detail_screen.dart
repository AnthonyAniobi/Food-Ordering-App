import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ordering_app/constants/app_images.dart';
import 'package:food_ordering_app/home_screen/models/restaurant_model.dart';
import 'package:food_ordering_app/widgets/custom_back_button.dart';
import 'package:food_ordering_app/widgets/product_list_widget.dart';
import 'package:food_ordering_app/widgets/rating_widget.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final RestaurantModel restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  bool _showHiddenWidget = true;
  final ScrollController _scrollController = ScrollController();
  late Map<String, List<ProductItem>> groupedList;
  late List<String> categories;
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showHiddenWidget = _scrollController.offset <= 50;
      });
    });
    groupedList = widget.restaurant.groupedProducts();
    categories = groupedList.keys.toList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            automaticallyImplyLeading: false,
            expandedHeight: 200.0,
            flexibleSpace: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: widget.restaurant.id,
                    child: Image.asset(
                      widget.restaurant.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(top: 30, left: 20, child: CustomBackButton()),
                AnimatedPositioned(
                  bottom: 10,
                  left: _showHiddenWidget ? 10 : 100,
                  duration: const Duration(milliseconds: 500),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF101F22).withAlpha(80),
                        ),
                        child: Text(
                          widget.restaurant.info,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: _showHiddenWidget ? 100 : 50,
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.restaurant.name,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${widget.restaurant.deliveryTime} delivery',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        RatingWidget(rating: widget.restaurant.rating),
                        const Spacer(),
                        SvgPicture.asset(
                          AppSvg.locationMinus,
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 13),
                        Text(
                          '2km away',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _FixedHeaderDelegate(
              height: 30,
              child: Container(
                color: Colors.white,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    bool selected = selectedTabIndex == index;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedTabIndex = index;
                        });
                      },
                      child: Container(
                        constraints: BoxConstraints(minWidth: 60),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                selected
                                    ? BorderSide(
                                      color: Color(0xFFd9d9d9),
                                      width: 2,
                                    )
                                    : BorderSide.none,
                          ),
                        ),
                        child: Text(
                          index == 0 ? 'All' : categories[index - 1],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight:
                                selected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: categories.length + 1,
                ),
              ),
            ),
          ),
          if (selectedTabIndex == 0)
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                {
                  final categoryKey = categories[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Text(
                          categoryKey,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: const Color(0x4F101010),
                          ),
                        ),
                      ),
                      ...groupedList[categoryKey]!.map((product) {
                        return ProductListWidget(
                          product: product,
                          restaurant: widget.restaurant,
                        );
                      }),
                    ],
                  );
                }
              }, childCount: categories.length),
            )
          else
            Builder(
              builder: (context) {
                final selectedCategory = categories[selectedTabIndex - 1];
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: groupedList[selectedCategory]!.length,
                    (context, index) {
                      final product = groupedList[selectedCategory]![index];
                      return ProductListWidget(
                        product: product,
                        restaurant: widget.restaurant,
                      );
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _FixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  _FixedHeaderDelegate({required this.height, required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
