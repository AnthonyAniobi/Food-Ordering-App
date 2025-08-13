import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ordering_app/bag/bag_screen.dart';
import 'package:food_ordering_app/constants/app_images.dart';
import 'package:food_ordering_app/constants/app_utils.dart';
import 'package:food_ordering_app/home_screen/home_screen.dart';
import 'package:food_ordering_app/orders/orders_screen.dart';
import 'package:food_ordering_app/profile/profile_screen.dart';

class TabOverlay extends StatefulWidget {
  const TabOverlay({super.key});

  @override
  State<TabOverlay> createState() => _TabOverlayState();
}

class _TabOverlayState extends State<TabOverlay>
    with SingleTickerProviderStateMixin {
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    AppUtils.tabController = TabController(length: 4, vsync: this);
    AppUtils.tabController.addListener(() {
      setState(() {
        tabIndex = AppUtils.tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            controller: AppUtils.tabController,
            children: [
              HomeScreen(),
              BagScreen(),
              OrdersScreen(),
              ProfileScreen(),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              height: 65,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF936002).withAlpha(60),
                    blurRadius: 9,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 21, vertical: 12),
              child: Row(
                children: [
                  tabIcon(AppSvg.homeActive, AppSvg.homeInactive, 'Home', 0),
                  tabIcon(AppSvg.bagActive, AppSvg.bagInactive, 'Bag', 1),
                  tabIcon(
                    AppSvg.ordersActive,
                    AppSvg.ordersInactive,
                    'Orders',
                    2,
                  ),
                  tabIcon(
                    AppSvg.profileActive,
                    AppSvg.profileInactive,
                    'Profile',
                    3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabIcon(
    String activeIcon,
    String inactiveIcon,
    String title,
    int index,
  ) {
    bool active = index == tabIndex;
    return Expanded(
      child: InkWell(
        onTap: () {
          AppUtils.tabController.animateTo(index);
          setState(() {
            tabIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedCrossFade(
              firstChild: SvgPicture.asset(activeIcon, width: 24, height: 24),
              secondChild: SvgPicture.asset(
                inactiveIcon,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  Color(0xFF101010).withAlpha(80),
                  BlendMode.srcIn,
                ),
              ),
              crossFadeState:
                  active ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 600),
            ),

            AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: active ? 1 : 0.3,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF101010),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
