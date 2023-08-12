import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final bool prescNeeded;

  CartItem({
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
    required this.prescNeeded,
  });
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  int get req {
    var req = 0;
    _items.forEach((key, cartitem) {
      if (cartitem.prescNeeded) {
        req += 1;
      }
    });
    return req;
  }

  double get totalAmt {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String prodId) {
    _items.remove(prodId);
    notifyListeners();
  }

  void addItem(
    String prodId,
    double price,
    String title,
    bool prescNeeded,
    int qua,
  ) {
    if (_items.containsKey(prodId)) {
      _items.update(
          prodId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                price: existingCartItem.price,
                quantity: qua,
                title: existingCartItem.title,
                prescNeeded: existingCartItem.prescNeeded,
              ));
    } else {
      _items.putIfAbsent(
          prodId,
          () => CartItem(
                id: DateTime.now().toString(),
                price: price,
                title: title,
                quantity: qua,
                prescNeeded: prescNeeded,
              ));
    }
    notifyListeners();
  }

  void removeSingleItem(String prodId) {
    if (!_items.containsKey(prodId)) {
      return;
    }
    if (_items[prodId]!.quantity > 1) {
      _items.update(
          prodId,
          (ex) => CartItem(
                id: ex.id,
                price: ex.price,
                quantity: ex.quantity - 1,
                title: ex.title,
                prescNeeded: ex.prescNeeded,
              ));
    } else {
      _items.remove(prodId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
