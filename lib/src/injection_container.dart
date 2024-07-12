import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';

import 'application/services/cart_service.dart';
import 'application/use_cases/use_cases.dart';
import 'infrastructure/repositories/repository.dart';

class InjectionContainer {
  static final InjectionContainer _instance = InjectionContainer._internal();

  factory InjectionContainer() {
    return _instance;
  }

  InjectionContainer._internal();

  late DartFakeStoreApiWrapper _apiWrapper;
  late Repository _repository;
  late UseCases _useCases;
  late CartService _cartService;

  void init() {
    _apiWrapper = DartFakeStoreApiWrapper();
    _repository = Repository(_apiWrapper);
    _useCases = UseCases(_repository);
    _cartService = CartService();
  }

  UseCases get useCases => _useCases;
  CartService get cartService => _cartService;
}
