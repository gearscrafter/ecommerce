import 'dart:async';

import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';

import '../../application/use_cases/use_cases.dart';

class SingleProductBloc {
  final UseCases _useCases;
  final _singleProductController = StreamController<ProductEntity>();

  Stream<ProductEntity> get hasProduct => _singleProductController.stream;

  SingleProductBloc(this._useCases);

  void getProduct(int productId) async {
    try {
      final result = await _useCases.fetchProductById(productId);
      _singleProductController.add(result);
    } catch (e) {
      _singleProductController.addError(e);
    }
  }

  void dispose() {
    _singleProductController.close();
  }
}
