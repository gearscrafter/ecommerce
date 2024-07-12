import 'dart:async';

import '../../application/use_cases/use_cases.dart';

class CategoriesBloc {
  final UseCases _useCases;
  final _categoryController = StreamController<List<String>>();

  Stream<List<String>> get hasCategories => _categoryController.stream;

  CategoriesBloc(this._useCases);

  void getCategories() async {
    try {
      final result = await _useCases.getCategories();
      _categoryController.add(result);
    } catch (e) {
      _categoryController.addError(e);
    }
  }

  void dispose() {
    _categoryController.close();
  }
}
