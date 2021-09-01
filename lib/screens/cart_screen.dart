import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/orders.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    // Add provider to listen the items added in the cart
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(cart.items.values.toList(), cart.totalAmount);
                      cart.clearCart();
                    },
                    child: Text(
                      'Order now',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctxt, i) => ci.CartItem(
                  quantity: cart.items.values.toList()[i].quantity,
                  id: cart.items.values.toList()[i].id,
                  price: cart.items.values.toList()[i].price,
                  name: cart.items.values.toList()[i].name,
                  productId: cart.items.keys.toList()[i],),
            ),
          ),
        ],
      ),
    );
  }
}
