import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ordering_app/constants/app_images.dart';

class RatingWidget extends StatelessWidget {
  final double rating;

  const RatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        star(rating >= 1),
        star(rating >= 2),
        star(rating >= 3),
        star(rating >= 4),
        star(rating >= 5),
      ],
    );
  }

  SvgPicture star(bool active) {
    return SvgPicture.asset(
      AppSvg.star,
      colorFilter: ColorFilter.mode(
        active ? Color(0xFFFFD700) : Color(0xFFC4C4C4),
        BlendMode.srcIn,
      ),
      height: 18,
      width: 18,
    );
  }
}
