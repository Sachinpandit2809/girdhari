import 'package:flutter/material.dart';

class RemoveStockProvider with ChangeNotifier {
  String _selectedCategory = 'Wholesale';

  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
