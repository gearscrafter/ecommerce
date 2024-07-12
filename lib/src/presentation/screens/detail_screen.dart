import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';
import 'package:ecommerce/src/presentation/blocs/single_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mosaic_flair/data/product_dart.dart';
import 'package:mosaic_flair/mosaic_flair.dart';

import '../../injection_container.dart';
import '../blocs/cart_bloc.dart';
import '../routes/app_routes.dart';

class DetailScreen extends StatefulWidget {
  final int productId;
  const DetailScreen({required this.productId, super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late SingleProductBloc _productBloc;
  late CartBloc _cartBloc;
  final _container = InjectionContainer();

  ProductEntity? _product;

  @override
  void initState() {
    final useCases = _container.useCases;
    final service = _container.cartService;
    _cartBloc = CartBloc(service);
    _productBloc = SingleProductBloc(useCases);
    _productBloc.getProduct(widget.productId);
    _productBloc.hasProduct.listen((product) {
      setState(() {
        _product = product;
      });
    }, onError: (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _productBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetailsTemplate(
      onAddToCart: (product, quantity) {
        if (product != null) {
          _cartBloc.addToCart(product, quantity);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  'Se agregó el producto exitosamente',
                  style: TextStyle(color: Colors.white),
                )),
          );
        }
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      },
      product: Product(
          name: _product?.title ?? '',
          description: _product?.description ?? '',
          price: _product?.price ?? 0.0,
          image: _product?.image),
    );
  }
}
