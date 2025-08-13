import 'package:flutter/material.dart';
import 'package:food_ordering_app/constants/app_utils.dart';
import 'package:food_ordering_app/widgets/primary_button.dart';

class CheckoutSuccessScreen extends StatelessWidget {
  const CheckoutSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                'Yum!\nYour order is in the works',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Text(
                "We'll keep you updated every step of the way so you know exactly when to expect your meal",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF797D82),
                ),
              ),
              Image.asset('assets/images/order_complete.png'),
              const Spacer(),
              PrimaryButton(
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  AppUtils.tabController.animateTo(0);
                },
                text: 'Continue Shopping',
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
