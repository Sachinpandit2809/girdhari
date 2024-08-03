import 'package:flutter/material.dart';

class ExpensesProvider with ChangeNotifier {
  String _selectedCategory = 'Raw Material';

  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
