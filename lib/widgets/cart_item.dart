import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String name;
  final String productId;

  CartItem({this.quantity, this.id, this.name, this.price, this.productId});

  @override
  Widget build(BuildContext context) {
    //Dismissible allows the deleting by swipe
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 35,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$$price'),
                ),
              ),
            ),
            title: Text(name),
            subtitle: Text(
              'Total : \$${(price * quantity)}',
              style: TextStyle(fontFamily: 'Lato'),
            ),
            trailing: Text('$quantity x'),
          ),
          padding: EdgeInsets.all(8),
        ),
      ),
    );
  }
}
