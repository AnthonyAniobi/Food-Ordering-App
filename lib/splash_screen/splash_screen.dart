import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_ordering_app/home_screen/home_screen.dart';
import 'package:food_ordering_app/widgets/primary_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Spacer(),
          Image.asset(
            'assets/images/splash_image.png',
            width: double.maxFinite,
          ),
          Text(
            'Food to blow your mind!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 17),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Whether youre craving pizza, sushi, or something in between, we have got your back.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF797D82),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: PrimaryButton(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ),
                );
              },
              text: 'Get Started',
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
