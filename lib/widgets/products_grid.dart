import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {

  final bool showFavs;
  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    // This widget is listening to the provider of all products.
    final productsData = Provider.of<ProductsProvider>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      // const avoid rebuilds
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      //gridDelegate allows us to define how the grid should be structured
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      // Provider to listen to changes of this product
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        // return a signle item product
        value: products[index],
        // then we don't need these arguments
        child: ProductItem(
            // id: products[index].id,
            // name: products[index].name,
            // imageUrl: products[index].imageUrl
            ),
      ),
    );
  }
}
