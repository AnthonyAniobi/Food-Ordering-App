import 'dart:developer';

import 'package:flutter/material.dart';

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
            child: InkWell(
              onTap: () {
                log('Button Pressed');
              },
              child: Container(
                height: 61,
                width: double.maxFinite,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: const Color(0xFFFFA500),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: const Color(0xFF101010),
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
