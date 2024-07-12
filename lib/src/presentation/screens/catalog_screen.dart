import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:mosaic_flair/data/category_data.dart';
import 'package:mosaic_flair/data/product_dart.dart';
import 'package:mosaic_flair/mosaic_flair.dart';

import '../../injection_container.dart';
import '../blocs/all_products_bloc.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/categories_bloc.dart';
import '../routes/app_routes.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late AllProductsBloc _productsBloc;
  late CartBloc _cartBloc;
  late CategoriesBloc _categoriesBloc;
  final _container = InjectionContainer();

  List<ProductEntity> listProducts = <ProductEntity>[];
  List<String> listCategories = <String>[];

  @override
  void initState() {
    final useCases = _container.useCases;
    final service = _container.cartService;
    _cartBloc = CartBloc(service);
    _productsBloc = AllProductsBloc(useCases);
    _categoriesBloc = CategoriesBloc(useCases);
    _productsBloc.fetchProducts();
    _categoriesBloc.getCategories();
    _categoriesBloc.hasCategories.listen((list) {
      setState(() {
        listCategories = list;
      });
    }, onError: (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    });
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

  List<Category> _mapStringsToCategories(
      List<String> categories, List<ProductEntity> entities) {
    return categories.map((object) {
      final productsInCategory =
          entities.where((product) => product.category == object).toList();
      final convertedProducts = productsInCategory.map((productEntity) {
        return Product(
          name: productEntity.title,
          description: productEntity.description,
          price: productEntity.price,
          image: productEntity.image,
        );
      }).toList();
      return Category(name: object, products: convertedProducts);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: CatalogTemplate(
        items: _mapStringsToCategories(listCategories, listProducts),
        getProduct: (product) {
          if (product != null) {
            _cartBloc.addToCart(product, 1);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    'Se agregó el producto exitosamente',
                    style: TextStyle(color: Colors.white),
                  )),
            );
          }
        },
        onTapCart: () {
          Navigator.pushNamed(context, AppRoutes.cart);
        },
        onTapContact: () {
          Navigator.pushNamed(context, AppRoutes.contact);
        },
        onTapSearch: () {
          Navigator.pushNamed(context, AppRoutes.search);
        },
        onTapHome: () {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        },
        onTapSupport: () {
          Navigator.pushNamed(context, AppRoutes.support);
        },
      ),
    );
  }
}
