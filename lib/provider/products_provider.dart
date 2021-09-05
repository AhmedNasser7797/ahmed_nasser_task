import 'dart:math';

import 'package:fiction_task/model/cart_model.dart';
import 'package:fiction_task/model/product_model.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class ProductsProvider with ChangeNotifier {
  var _random = Random();
  List<ProductModel> _products = [
    ProductModel(
      id: 1,
      name: 'product1',
      price: 50,
      description: "Description for product 1",
      numberInStock: 40,
      isFavorite: false,
      imageUrl: 'assets/images/persons-wrist-wearing.jpg',
    ),
    ProductModel(
      id: 2,
      name: 'product2',
      price: 100,
      description: "Description for product 2",
      numberInStock: 30,
      isFavorite: false,
      imageUrl: 'assets/images/wrist-watches.jpg',
    ),
    ProductModel(
      id: 3,
      name: 'product3',
      price: 70,
      description: "Description for product 3",
      numberInStock: 60,
      isFavorite: false,
      imageUrl: "assets/images/photography-product-download.jpg",
    ),
  ];
  List<ProductModel> get products => _products;

  List<ProductModel> get _favorites =>
      _products.where((element) => element.isFavorite == true).toList();
  List<ProductModel> get favorites => _favorites;

  List<CartModel> _cart = [];
  List<CartModel> get cart => _cart;

  void addToCart(ProductModel product) {
    for (int i = 0; i < _cart.length; i++) {
      if (_cart[i].product.id == product.id) return;
    }

    _cart.add(
      CartModel(
        product: product,
        cartCount: 0,
      ),
    );
    notifyListeners();
  }

  void removeFromCart(CartModel cart) {
    _cart.removeWhere((element) => element == cart);
    notifyListeners();
  }

  void addProduct(ProductModel product) {
    _products.add(product);
    notifyListeners();
  }

  void addToFavorite(ProductModel product) {
    _products.firstWhere((element) => element == product).isFavorite = true;
    notifyListeners();
  }

  void setFavorite(ProductModel product) {
    final temp = _products.firstWhere((element) => element == product);

    temp.isFavorite = !temp.isFavorite;
    notifyListeners();
  }
}
