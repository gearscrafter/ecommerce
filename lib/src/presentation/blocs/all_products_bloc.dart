import 'dart:async';

import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';

import '../../application/use_cases/use_cases.dart';

class AllProductsBloc {
  final UseCases _useCases;
  final _allProductsController = StreamController<List<ProductEntity>>();

  Stream<List<ProductEntity>> get hasList => _allProductsController.stream;

  AllProductsBloc(this._useCases);

  void fetchProducts() async {
    try {
      final result = await _useCases.fetchAllProducts();
      _allProductsController.add(result);
    } catch (e) {
      _allProductsController.addError(e);
    }
  }

  void dispose() {
    _allProductsController.close();
  }
}
