import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:mosaic_flair/mosaic_flair.dart';

import '../../core/utils/details_screen_argument.dart';
import '../blocs/all_products_bloc.dart';
import '../../injection_container.dart';
import '../blocs/info_bloc.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AllProductsBloc _productsBloc;
  late InfoBloc _infoBloc;
  final _container = InjectionContainer();

  String userName = 'user';
  List<ProductEntity> listProducts = <ProductEntity>[];

  @override
  void initState() {
    final useCases = _container.useCases;
    _productsBloc = AllProductsBloc(useCases);
    _infoBloc = InfoBloc(useCases);
    _infoBloc.getInfo('1');
    _productsBloc.fetchProducts();
    _infoBloc.hasInfo.listen((info) {
      setState(() {
        userName = info.name?.firstname ?? '';
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

  List<PromotionCard> _mapProductEntitiesToPromotions(
      List<ProductEntity> entities) {
    return entities.where((entity) => entity.rating.rate < 3.0).map((entity) {
      return PromotionCard(
        extentDescription: '',
        description: '',
        image: entity.image,
        percentage: 50.0,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: HomeTemplate(
        userName: userName,
        products: _mapProductEntitiesToCards(listProducts),
        promotionCards: _mapProductEntitiesToPromotions(listProducts),
        onTapCart: () {
          Navigator.pushNamed(context, AppRoutes.cart);
        },
        onTapContact: () {
          Navigator.pushNamed(context, AppRoutes.contact);
        },
        onTapSearch: () {
          Navigator.pushNamed(context, AppRoutes.search);
        },
        onTapSeeMore: () {
          Navigator.pushNamed(context, AppRoutes.catalog);
        },
        onTapSupport: () {
          Navigator.pushNamed(context, AppRoutes.support);
        },
        onTapProducts: () {
          Navigator.pushNamed(context, AppRoutes.catalog);
        },
        productSelected: (id) {
          Navigator.pushNamed(context, AppRoutes.detail,
              arguments: DetailsScreenArguments(productId: id));
        },
      ),
    );
  }
}
