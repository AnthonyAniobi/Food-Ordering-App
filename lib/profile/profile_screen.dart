import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ordering_app/constants/app_images.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFF101010).withAlpha(20),
            child: Icon(Icons.person, size: 40),
          ),
          SizedBox(height: 20),
          Text(
            'John Doe',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 9),
          Text(
            '102nd St Ports, New York',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF797D82),
            ),
          ),
          SizedBox(height: 9),
          Text(
            '2324-3543-34',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF797D82),
            ),
          ),
          SizedBox(height: 40),
          profileTile(AppSvg.card, 'Payment Methods', '2 cards added'),
          SizedBox(height: 40),
          profileTile(
            AppSvg.homeInactive,
            'Delivery Address',
            '102nd St Ports, New York',
          ),
          SizedBox(height: 40),
          profileTile(
            AppSvg.setting,
            'Settings',
            'Notification | FAQ | Contact',
          ),
        ],
      ),
    );
  }

  Padding profileTile(String svg, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFF101010).withAlpha(20),
            child: SvgPicture.asset(svg),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF797D82),
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF797D82),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
