import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:mosaic_flair/data/product_dart.dart';

import '../../application/services/cart_service.dart';

class CartBloc with ChangeNotifier {
  final CartService _cartService;
  final _cartController = StreamController<List<Product>>();

  Stream<List<Product>> get cartItems => _cartController.stream;

  CartBloc(this._cartService) {
    _cartController.add(_cartService.getCartItems());
  }

  void addToCart(Product product, int quantity) {
    _cartService.addToCart(product, quantity);
    _cartController.add(_cartService.getCartItems());
    notifyListeners();
  }

  void removeCart(Product product) {
    _cartService.removeFromCart(product);
    _cartController.add(_cartService.getCartItems());
    notifyListeners();
  }

  @override
  void dispose() {
    _cartController.close();
    super.dispose();
  }
}
