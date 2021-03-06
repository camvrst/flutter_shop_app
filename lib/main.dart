import 'package:flutter/material.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './providers/cart.dart';
import 'package:provider/provider.dart';
import './screens/products_overview_screen.dart';
import './screens/product_details_screen.dart';
import './providers/products_provider.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ChangeNotifier is a provider
    // Allows that only child widgets that are listening are rebuild
    // To listen these provides from anywhere in the app
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctxt) => ProductsProvider()),
        ChangeNotifierProvider(
          create: (ctxt) => Cart(),
        ),
        ChangeNotifierProvider(create: (ctxt) => Orders()),
      ],
      // Should return a new instance of our provided class
      // Widgets who are listening will be rebuild if changes are made in the provider.
      // We coulf have used ChangeNotifierProvider.value
      // value: ProductsProvider()
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          accentColor: Colors.purple,
          fontFamily: 'Anton',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctxt) => ProductDetailScreen(),
          CartScreen.routeName: (ctxt) => CartScreen(),
          OrdersScreen.routeName: (ctxt) => OrdersScreen(),
          UserProductsScreen.routeName: (ctxt) => UserProductsScreen(),
          EditProductScreen.routeName: (ctxt) => EditProductScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}
