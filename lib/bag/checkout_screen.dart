import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_ordering_app/bag/checkout_success_screen.dart';
import 'package:food_ordering_app/bag/model/bag_model.dart';
import 'package:food_ordering_app/constants/secret_keys.dart';
import 'package:food_ordering_app/orders/model/address_model.dart';
import 'package:food_ordering_app/orders/model/order_model.dart';
import 'package:food_ordering_app/widgets/custom_back_button.dart';
import 'package:food_ordering_app/widgets/primary_button.dart';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  ValueNotifier<bool> processingPayment = ValueNotifier(false);

  GlobalKey<FormState> formState = GlobalKey();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: CustomBackButton(darkBackground: true),
        centerTitle: true,
        title: Text(
          'Checkout',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: formState,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(height: 20),
            Text(
              'Deliver to:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                label: Text('Name'),
                border: OutlineInputBorder(),
              ),
              validator:
                  (txt) => (txt?.isEmpty ?? true) ? 'Enter a valid name' : null,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                label: Text('Email'),
                border: OutlineInputBorder(),
              ),
              validator:
                  (txt) =>
                      (txt?.isEmpty ?? true) ? 'Enter a valid email' : null,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                label: Text('Phone Number'),
                border: OutlineInputBorder(),
              ),
              validator:
                  (txt) =>
                      (txt?.isEmpty ?? true)
                          ? 'Enter a valid phone number'
                          : null,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: cityController,
              decoration: InputDecoration(
                label: Text('City'),
                border: OutlineInputBorder(),
              ),
              validator:
                  (txt) => (txt?.isEmpty ?? true) ? 'Enter a valid city' : null,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: stateController,
              decoration: InputDecoration(
                label: Text('State'),
                border: OutlineInputBorder(),
              ),
              validator:
                  (txt) =>
                      (txt?.isEmpty ?? true) ? 'Enter a valid state' : null,
            ),
            SizedBox(height: 50),
            ValueListenableBuilder(
              valueListenable: processingPayment,
              builder: (context, loading, _) {
                return PrimaryButton(
                  onTap: makePayment,
                  text: 'Confirm Order',
                  isLoading: loading,
                );
              },
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    if (formState.currentState?.validate() != true) {
      return;
    }

    processingPayment.value = true;
    try {
      final bag = BagModel();
      double cartPrice = bag.totalPrice;
      double deliveryFee = 12.0;
      double amountInCents = (cartPrice + deliveryFee) * 100;
      final uniqueId = Uuid().v4();
      final deviceId = await getDeviceId();
      final address = UserAdressModel(
        name: nameController.text,
        phoneNumber: phoneController.text,
        address: addressController.text,
        state: stateController.text,
        city: cityController.text,
        country: 'US',
      );

      final order = OrderModel(
        deviceId: deviceId,
        orderId: uniqueId,
        status: 'pending',
        date: DateTime.now(),
        items: bag.items,
        deliveryFee: deliveryFee,
        address: address,
        info: null,
      );

      final paymentIntentData = await _createPaymentIntent(
        amountInCents.round(),
        'usd',
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: "Restaurant App",
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          style: ThemeMode.light,
          billingDetails: BillingDetails(
            phone: phoneController.text,
            email: emailController.text,
            address: Address(
              city: cityController.text,
              country: 'US',
              line1: addressController.text,
              line2: null,
              postalCode: null,
              state: stateController.text,
            ),
          ),
          billingDetailsCollectionConfiguration:
              BillingDetailsCollectionConfiguration(
                name: CollectionMode.always,
                address: AddressCollectionMode.never,
                attachDefaultsToPaymentMethod: true,
                email: CollectionMode.never,
                phone: CollectionMode.never,
              ),
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      await FirebaseFirestore.instance
          .collection('orders')
          .doc(uniqueId)
          .set(order.toJson());

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CheckoutSuccessScreen();
          },
        ),
      );
      bag.clearCart();
    } on StripeException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.error.localizedMessage}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      processingPayment.value = false;
    }
  }

  Future<Map<String, dynamic>> _createPaymentIntent(
    int amount,
    String currency,
  ) async {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');

    final response = await http.post(
      url,
      body: {'amount': amount.toString(), 'currency': currency},
      headers: {'Authorization': 'Bearer $stripeSecretKey'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create Payment Intent: ${response.body}');
    }

    return jsonDecode(response.body);
  }

  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? '';
    } else {
      return '';
    }
  }
}
