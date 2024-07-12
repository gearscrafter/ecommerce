import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';

abstract class IRepository {
  Future<List<ProductEntity>> fetchProducts();
  Future<ProductEntity> getProduct(int productId);
  Future<CartEntity> addToCart(CartEntity cart);
  Future<IdEntity> register(UserEntity userData);
  Future<TokenEntity> signIn(UserEntity userData);
  Future<UserEntity> info(String userId);
  Future<List<String>> getCategories();
}
