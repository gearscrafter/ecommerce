import 'dart:async';

import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';

import '../../application/use_cases/use_cases.dart';

class RegisterBloc {
  final UseCases _useCases;
  final _registerController = StreamController<IdEntity>();

  Stream<IdEntity> get haveRegister => _registerController.stream;

  RegisterBloc(this._useCases);

  void register(UserEntity user) async {
    try {
      final id = await _useCases.registerUser(user);
      _registerController.add(id);
    } catch (e) {
      _registerController.addError(e);
    }
  }

  void dispose() {
    _registerController.close();
  }
}
