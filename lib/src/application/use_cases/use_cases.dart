import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';

import '../../domain/repositories/repository.dart';

class UseCases {
  final IRepository repository;

  UseCases(this.repository);

  Future<List<ProductEntity>> fetchAllProducts() {
    return repository.fetchProducts();
  }

  Future<ProductEntity> fetchProductById(int productId) {
    return repository.getProduct(productId);
  }

  Future<CartEntity> addProductToCart(CartEntity cart) {
    return repository.addToCart(cart);
  }

  Future<IdEntity> registerUser(UserEntity user) {
    return repository.register(user);
  }

  Future<TokenEntity> loginUser(UserEntity user) {
    return repository.signIn(user);
  }

  Future<UserEntity> getUserInfo(String userId) {
    return repository.info(userId);
  }

  Future<List<String>> getCategories() {
    return repository.getCategories();
  }
}
