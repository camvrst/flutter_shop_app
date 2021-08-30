import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.name,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return {...items};
  }

  void addItem(String productId, double price, String name) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) =>
            CartItem(id: productId, name: name, price: price, quantity: existingCartItem.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            name: name,
            price: price,
            quantity: 1),
      );
    }
  }
}
