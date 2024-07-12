import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:mosaic_flair/mosaic_flair.dart';

import '../../application/services/cart_service.dart';
import '../../injection_container.dart';
import '../blocs/all_products_bloc.dart';
import '../routes/app_routes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late AllProductsBloc _productsBloc;
  final _container = InjectionContainer();

  List<ProductEntity> listProducts = <ProductEntity>[];
  final _service = CartService();

  @override
  void initState() {
    final useCases = _container.useCases;
    _productsBloc = AllProductsBloc(useCases);
    _productsBloc.fetchProducts();
    _productsBloc.hasList.listen((list) {
      setState(() {
        listProducts = list;
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
    _productsBloc.dispose();
    super.dispose();
  }

  List<ProductCard> _mapProductEntitiesToCards(List<ProductEntity> entities) {
    return entities.map((entity) {
      return ProductCard(
        id: entity.id,
        title: entity.title,
        category: entity.category,
        image: entity.image,
        price: entity.price,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SearchTemplate(
      productCards: _mapProductEntitiesToCards(listProducts),
      getProduct: (product) {
        if (product != null) {
          _service.addToCart(product, 1);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Se añadio un ${product.name} al carrito 🚀')),
          );
        }
      },
      onTapContact: () {
        Navigator.pushNamed(context, AppRoutes.contact);
      },
      onTapHome: () {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      },
      onTapSupport: () {
        Navigator.pushNamed(context, AppRoutes.support);
      },
    );
  }
}
