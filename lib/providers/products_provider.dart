import 'package:flutter/material.dart';
import './products.dart';

// mixin to merge some properties (heritance)
class ProductsProvider with ChangeNotifier {
  List<Products> _items = [
    Products(
      id: 'p1',
      name: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Products(
      id: 'p2',
      name: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Products(
      id: 'p3',
      name: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Products(
      id: 'p4',
      name: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // Change view

  //var _showFavoritesOnly = false;

  List<Products> get items {
    //if (_showFavoritesOnly) {

    //}
    // return a copy of the items, that's why we use spread operator
    return [..._items];
  }

  // We don't use these 2 methods in here as it's a widget state and not an app state.

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  //   void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  List<Products> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Products findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct(Products product) {
    final newProduct = Products(
        name: product.name,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
        id: DateTime.now().toString());
    _items.add(newProduct);
    // changeNotifier give us access to notifyListeners.
    // it allows all our widgets to know when something is changed in the items list.
    // communication is made between this class & widgets that are interested.
    // if there is a change, these widgets are rebuild.
    notifyListeners();
  }
}
