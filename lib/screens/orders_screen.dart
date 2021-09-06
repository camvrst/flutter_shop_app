import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/orders.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:flutter_shop_app/widgets/order_item.dart' as ordItem;
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  // // var _isLoading = false;
  // @override
  // void initState() {
  //   //Future.delayed(Duration.zero).then((_) async { not needed cause listen false
  //   // _isLoading = true;
  //   // Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
  //   //   setState(() {
  //   //     _isLoading = false;
  //   //   });
  //   // });
  //   //});
  //   super.initState();
  // }

  // Aternative to init state  with async await => FutureBuilder

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctxt, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Text('An error occured');
            } else {
              // consumer for orderData to avoid rebuilding the entire widget
              return Consumer<Orders>(
                builder: (ctxt, orderData, child) => ListView.builder(
                  itemBuilder: (ctxt, i) =>
                      ordItem.OrderItem(orderData.orders[i]),
                  itemCount: orderData.orders.length,
                ),
              );
            }
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
