import 'dart:async';

import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';

import '../../application/use_cases/use_cases.dart';

class LoginBloc {
  final UseCases _useCases;
  final _loginController = StreamController<TokenEntity>();

  Stream<TokenEntity> get haveLogin => _loginController.stream;

  LoginBloc(this._useCases);

  void login(UserEntity user) async {
    try {
      final token = await _useCases.loginUser(user);
      _loginController.add(token);
    } catch (e) {
      _loginController.addError(e);
    }
  }

  void dispose() {
    _loginController.close();
  }
}
