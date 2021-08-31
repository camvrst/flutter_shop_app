import 'package:flutter/foundation.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> product;
  final DateTime dateTime;

  OrderItem({this.id, this.amount, this.dateTime, this.product});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(
    List<CartItem> cartProducts,
    double total,
  ) {
    // insert, to add at index 0 instead of the end of the list as add()
    _orders.insert(
      0,
      OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          dateTime: DateTime.now(),
          product: cartProducts),
    );
    notifyListeners();
  }
}
