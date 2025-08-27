import 'package:flutter/material.dart';
import 'package:food_ordering_app/bag/model/bag_item.dart';
import 'package:food_ordering_app/orders/model/address_model.dart';
import 'package:food_ordering_app/orders/model/delivery_information.dart';

class OrderModel {
  final String orderId;
  final String deviceId;
  final String status;
  final DateTime date;
  final List<BagItem> items;
  final double deliveryFee;
  final DeliveryInformation? info;
  final UserAdressModel address;

  double get subtotal =>
      items.fold(0, (prev, item) => prev + (item.price * item.quantity));
  double get total => subtotal + deliveryFee;
  int get quantity => items.fold(0, (prev, item) => prev + item.quantity);

  Color get statusColor => switch (status) {
    'pending' => Colors.grey,
    'delivered' => Colors.green,
    'cancelled' => Colors.red,
    _ => Colors.orange,
  };

  String get statusText => switch (status) {
    'delivered' => 'Completed',
    'confirmed' => 'Preparing',
    'pending' => 'In Progress',
    'cancelled' => 'Cancelled',
    'dispatched' => 'In Delivery',
    _ => 'Invalid type',
  };

  OrderModel({
    required this.orderId,
    required this.deviceId,
    required this.status,
    required this.date,
    required this.items,
    required this.deliveryFee,
    required this.info,
    required this.address,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'],
      deviceId: json['deviceId'],
      status: json['status'],
      date: DateTime.parse(json['date']),
      items:
          (json['items'] as List)
              .map((item) => BagItem.fromJson(item))
              .toList(),
      deliveryFee: json['deliveryFee'],
      info:
          json['info'] == null
              ? null
              : DeliveryInformation.fromJson(json['info']),
      address: UserAdressModel.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'deviceId': deviceId,
    'status': status,
    'date': date.toString(),
    'items': items.map((item) => item.toJson()).toList(),
    'deliveryFee': deliveryFee,
    'info': info?.toJson(),
    'address': address.toJson(),
  };
}
