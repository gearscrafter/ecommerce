import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';
import 'package:ecommerce/src/presentation/blocs/add_cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mosaic_flair/data/cart_data.dart';
import 'package:mosaic_flair/data/product_dart.dart';
import 'package:mosaic_flair/mosaic_flair.dart';

import '../../injection_container.dart';
import '../blocs/cart_bloc.dart';
import '../routes/app_routes.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartBloc _cartBloc;
  late AddCartBloc _addCartBloc;
  List<Product> listProducts = <Product>[];

  final _container = InjectionContainer();

  @override
  void initState() {
    super.initState();
    final service = _container.cartService;
    final usecases = _container.useCases;
    _addCartBloc = AddCartBloc(usecases);
    _cartBloc = CartBloc(service);
    _cartBloc.cartItems.listen((cart) {
      setState(() {
        listProducts = cart;
      });
    }, onError: (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    });
    _addCartBloc.hasCart.listen((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'La transacción se realizo exitosamente',
              style: TextStyle(color: Colors.white),
            )),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }, onError: (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    });
  }

  List<CartItem> _mapProductsToCartItems(List<Product> products) {
    final Map<String, CartItem> cartItemMap = {};
    for (var product in products) {
      if (cartItemMap.containsKey(product.name)) {
        cartItemMap[product.name]!.quantity++;
      } else {
        cartItemMap[product.name] = CartItem(
          id: product.id ?? 0,
          name: product.name,
          image: product.image,
          price: product.price,
          quantity: 1,
        );
      }
    }
    return cartItemMap.values.toList();
  }

  List<ProductQuantityEntity> _mapProductsToParse(
      List<ProductQuantity> products) {
    return products.map((product) {
      return ProductQuantityEntity(
        productId: product.productId,
        quantity: product.quantity,
      );
    }).toList();
  }

  void _removeItem(int index) {
    if (index >= -1 && index < listProducts.length) {
      final product = listProducts[index];
      _cartBloc.removeCart(product);
    }
  }

  @override
  void dispose() {
    _addCartBloc.dispose();
    _cartBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = _mapProductsToCartItems(listProducts);
    return CartTemplate(
      cartItems: cartItems,
      onRemoveItem: _removeItem,
      onCheckout: (value) {
        _addCartBloc.addCart(CartEntity(
            userId: 1,
            date: DateTime.now(),
            products: _mapProductsToParse(value)));
      },
    );
  }
}
