import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_pharm_ui/providers/cart.dart';
import 'package:flutter/foundation.dart';

class OrderItem {
  final String id;
  final double amt;
  final List<CartItem> products;
  final DateTime datetTime;
  final String address;

  OrderItem({
    required this.amt,
    required this.datetTime,
    required this.id,
    required this.products,
    required this.address,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(
      List<CartItem> cartProducts, double total, String address) async {
    final url = Uri.parse(
        "https://e-pharmacy-42b9a-default-rtdb.asia-southeast1.firebasedatabase.app/order.json");
    final DateTime now = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'amt': total,
            'dateTime': now.toIso8601String(),
            'products': cartProducts
                .map(
                  (e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price,
                    'prescNeeded': e.prescNeeded
                  },
                )
                .toList(),
            'address': address,
          },
        ),
      );
      print(response.body);
    } catch (error) {
      rethrow;
    }

    _orders.insert(
        0,
        OrderItem(
          amt: total,
          datetTime: DateTime.now(),
          id: DateTime.now().toString(),
          products: cartProducts,
          address: address,
        ));
    notifyListeners();
  }
}
