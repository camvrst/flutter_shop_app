import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String name;
  // final double price;
  // final String imageUrl;
  // final String description;

  // ProductDetailScreen({this.name});

  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    // context = communication channel
    // listen = false means that it won't rebuild if the data from the provider change. 
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.name),
      ),
    );
  }
}
