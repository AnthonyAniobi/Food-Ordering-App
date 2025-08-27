import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/bag/model/bag_item.dart';
import 'package:food_ordering_app/orders/model/address_model.dart';
import 'package:food_ordering_app/orders/model/delivery_information.dart';
import 'package:food_ordering_app/orders/model/order_model.dart';
import 'package:food_ordering_app/widgets/order_item_widget.dart';
import 'package:shimmer/shimmer.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isLoading = true;
  List<OrderModel> orders = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'My Orders',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body:
          isLoading
              ? ListView.separated(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 100),
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Color(0xFFE0E0E0),
                    highlightColor: Colors.white,
                    child: Container(
                      height: 152,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 20),
                itemCount: 5,
              )
              : ListView.separated(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 100),
                itemBuilder: (context, index) {
                  return OrderItemWidget(order: orders[index]);
                },
                separatorBuilder: (context, index) => SizedBox(height: 20),
                itemCount: orders.length,
              ),
    );
  }

  Future<void> fetchOrders() async {
    try {
      setState(() {
        isLoading = true;
      });
      final snapshot =
          await FirebaseFirestore.instance
              .collection('orders')
              .orderBy('date', descending: true)
              .get();
      final fetchedOrders = snapshot.docs.map((doc) {
        return OrderModel.fromJson(doc.data());
      });
      setState(() {
        orders = fetchedOrders.toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to fetch orders: $e')));
    }
  }
}

List<OrderModel> _orders = [
  OrderModel(
    orderId: '299823423',
    deviceId: 'deviceId',
    status: 'pending',
    date: DateTime.now(),
    items: _items.sublist(2),
    deliveryFee: 12.0,
    info: null,
    address: UserAdressModel(
      name: 'John doe',
      phoneNumber: '1234567',
      address: 'someplace',
      city: 'city',
      state: 'state',
      country: 'US',
    ),
  ),
  OrderModel(
    orderId: '156523423',
    deviceId: 'deviceId',
    status: 'confirmed',
    date: DateTime.now(),
    items: _items,
    deliveryFee: 12.0,
    info: null,
    address: UserAdressModel(
      name: 'John doe',
      phoneNumber: '1234567',
      address: 'someplace',
      city: 'city',
      state: 'state',
      country: 'US',
    ),
  ),
  OrderModel(
    orderId: '121223423',
    deviceId: 'deviceId',
    status: 'delivered',
    date: DateTime.now(),
    items: _items.sublist(1),
    deliveryFee: 12.0,
    info: null,
    address: UserAdressModel(
      name: 'John doe',
      phoneNumber: '1234567',
      address: 'someplace',
      city: 'city',
      state: 'state',
      country: 'US',
    ),
  ),
  OrderModel(
    orderId: '987223423',
    deviceId: 'deviceId',
    status: 'dispatched',
    date: DateTime.now(),
    items: _items,
    deliveryFee: 12.0,
    info: DeliveryInformation(
      contractName: 'John doe',
      contactPhone: '12345678',
      status: 'In Progress',
      latitude: '6.5603153853968035',
      longitude: '3.3450320813345202',
    ),
    address: UserAdressModel(
      name: 'John doe',
      phoneNumber: '1234567',
      address: 'someplace',
      city: 'city',
      state: 'state',
      country: 'US',
    ),
  ),
  OrderModel(
    orderId: '763423423',
    deviceId: 'deviceId',
    status: 'cancelled',
    date: DateTime.now(),
    items: _items.sublist(1),
    deliveryFee: 12.0,
    info: null,
    address: UserAdressModel(
      name: 'John doe',
      phoneNumber: '1234567',
      address: 'someplace',
      city: 'city',
      state: 'state',
      country: 'US',
    ),
  ),
];

List<BagItem> _items = [
  BagItem(
    productId: '0',
    restaurantId: 'res1',
    restaurantName: 'The Pizza Place',
    name: 'Kings Deal',
    image: 'assets/images/products/pizza1.png',
    size: '',
    price: 25.5,
    details: 'large, BBQ meat',
  ),
  BagItem(
    productId: '10',
    restaurantId: 'res2',
    restaurantName: 'Burger King',
    name: 'Salad',
    image: 'assets/images/products/salad.png',
    size: '',
    price: 15.2,
    details: 'small',
    quantity: 2,
  ),
  BagItem(
    productId: '11',
    restaurantId: 'res3',
    restaurantName: 'The Ice Cream Factory',
    name: 'Soda',
    image: 'assets/images/products/cocacola.png',
    size: '',
    price: 10.0,
    details: 'coke',
    quantity: 3,
  ),
];
