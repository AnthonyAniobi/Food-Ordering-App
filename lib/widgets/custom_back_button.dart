import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ordering_app/constants/app_images.dart';

class CustomBackButton extends StatelessWidget {
  final bool darkBackground;

  const CustomBackButton({super.key, this.darkBackground = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 51,
        height: 51,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: (darkBackground ? Color(0xFF101010) : Colors.white).withAlpha(
            100,
          ),
        ),
        child: SvgPicture.asset(AppSvg.arrowLeft),
      ),
    );
  }
}
