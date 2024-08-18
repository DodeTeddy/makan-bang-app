import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  int _index = 0;
  int _categoryId = 1;

  int get index => _index;
  int get categoryId => _categoryId;

  void setCategoryId(int index, int categoryId) {
    _index = index;
    _categoryId = categoryId;
    notifyListeners();
  }
}
