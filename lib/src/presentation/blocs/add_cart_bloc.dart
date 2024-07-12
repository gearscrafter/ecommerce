import 'dart:async';

import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';

import '../../application/use_cases/use_cases.dart';

class AddCartBloc {
  final UseCases _useCases;
  final _addCartController = StreamController<CartEntity>();

  Stream<CartEntity> get hasCart => _addCartController.stream;

  AddCartBloc(this._useCases);

  void addCart(CartEntity cart) async {
    try {
      final result = await _useCases.addProductToCart(cart);
      _addCartController.add(result);
    } catch (e) {
      _addCartController.addError(e);
    }
  }

  void dispose() {
    _addCartController.close();
  }
}
