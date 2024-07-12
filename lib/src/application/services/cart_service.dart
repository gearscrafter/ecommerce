import 'package:mosaic_flair/data/product_dart.dart';

class CartService {
  static final CartService _instance = CartService._internal();

  factory CartService() => _instance;

  CartService._internal();

  final List<Product> _cartItems = [];

  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.name == product.name);
  }

  void addToCart(Product product, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cartItems.add(product);
    }
  }

  List<Product> getCartItems() => _cartItems;

  void clearCart() {
    _cartItems.clear();
  }
}
