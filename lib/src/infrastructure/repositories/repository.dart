import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';
import 'package:ecommerce/src/domain/repositories/repository.dart';

class Repository implements IRepository {
  final DartFakeStoreApiWrapper _apiWrapper;

  Repository(this._apiWrapper);

  @override
  Future<List<ProductEntity>> fetchProducts() async {
    try {
      final products = await _apiWrapper.runFetchProducts();
      return products;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ProductEntity> getProduct(int productId) async {
    try {
      final product = await _apiWrapper.runFetchSingleProduct(productId);
      return product;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<CartEntity> addToCart(CartEntity cart) async {
    try {
      final cartResult = await _apiWrapper.runSendProductToCart(cart);
      return cartResult;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<IdEntity> register(UserEntity userData) async {
    try {
      final result = await _apiWrapper.runSendRegister(userData);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<TokenEntity> signIn(UserEntity userData) async {
    try {
      final result = await _apiWrapper.runSendSignIn(userData);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserEntity> info(String userId) async {
    try {
      final result = await _apiWrapper.runFetchInfo(userId);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      final result = await _apiWrapper.runFetchCategories();
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
