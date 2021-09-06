import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_shop_app/widgets/order_item.dart';
import 'package:http/http.dart' as http;
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

  Future<void> fetchAndSetOrders() async {
    const url =
        'https://flutter-shop-app-78020-default-rtdb.europe-west1.firebasedatabase.app/orders.json';
    try {
      final response = await http.get(Uri.parse(url));
      // this gives us a map, with a nested map
      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<OrderItem> loadedOrders = [];
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          product: (orderData['product'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  name: item['name'],
                  price: item['price'],
                  quantity: item['quantity'],
                ),
              )
              .toList(),
        ));
      });
      // items are replaced with the products fetched
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addOrder(
    List<CartItem> cartProducts,
    double total,
  ) async {
    const url =
        'https://flutter-shop-app-78020-default-rtdb.europe-west1.firebasedatabase.app/orders.json';
    // to avoid diff of datetime due to http and have the same timestamp
    final timestamp = DateTime.now();

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'product': cartProducts
              .map((product) => {
                    'id': product.id,
                    'name': product.name,
                    'quantity': product.quantity,
                    'price': product.price,
                  })
              .toList(),
        }),
      );
      // insert, to add at index 0 instead of the end of the list as add()
      final newOrder = OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        product: cartProducts,
      );
      _orders.insert(
        0,
        newOrder,
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
