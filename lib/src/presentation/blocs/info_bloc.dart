import 'dart:async';

import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';

import '../../application/use_cases/use_cases.dart';

class InfoBloc {
  final UseCases _useCases;
  final _infoController = StreamController<UserEntity>();

  Stream<UserEntity> get hasInfo => _infoController.stream;

  InfoBloc(this._useCases);

  void getInfo(String userId) async {
    try {
      final result = await _useCases.getUserInfo(userId);
      _infoController.add(result);
    } catch (e) {
      _infoController.addError(e);
    }
  }

  void dispose() {
    _infoController.close();
  }
}
