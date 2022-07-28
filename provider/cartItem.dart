import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product.dart';
import 'package:flutter/material.dart';

class CartItem extends ChangeNotifier {
  List<Product> productsCartItem = [];
  addProduct(Product product) {
    if (productsCartItem.contains(product)) {
      show_toast('You added this item before');
      return;
    }
    productsCartItem.add(product);
    show_toast('added to cart');
    notifyListeners();
  }

  deleteFromCart(Product product) {
    productsCartItem.remove(product);
    notifyListeners();
    print('deleted');
  }
}
