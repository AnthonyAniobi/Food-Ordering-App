import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ordering_app/constants/app_images.dart';
import 'package:food_ordering_app/home_screen/models/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  child: Image.asset(restaurant.image, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.black,
                  child: SvgPicture.asset(
                    AppSvg.horizontalArrow,
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Text(
          restaurant.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            star(),
            star(),
            star(),
            star(),
            star(),
            const Spacer(),
            SvgPicture.asset(
              AppSvg.locationMinus,
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            SizedBox(width: 13),
            Text(
              '2km away',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 30),
      ],
    );
  }

  SvgPicture star() {
    return SvgPicture.asset(
      AppSvg.star,
      colorFilter: ColorFilter.mode(Color(0xFFFFD700), BlendMode.srcIn),
      height: 18,
      width: 18,
    );
  }
}

class CustomCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 30;
    double curveRadius = 20;
    Path path = Path();
    path.moveTo(radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height - (curveRadius + 60));
    path.quadraticBezierTo(
      size.width,
      size.height - 60,
      size.width - curveRadius,
      size.height - 60,
    );
    path.quadraticBezierTo(
      size.width - 70,
      size.height - 65,
      size.width - 75,
      size.height - curveRadius,
    );
    path.quadraticBezierTo(
      size.width - 75,
      size.height,
      size.width - (75 + curveRadius),
      size.height,
    );
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);
    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
