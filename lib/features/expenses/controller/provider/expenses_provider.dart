// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:girdhari/features/expenses/model/expenses_model.dart';

// class ExpensesProvider with ChangeNotifier {
//   final expensesCollection =
//       FirebaseFirestore.instance.collection('expensesStore');

//   Future<void> addExpenses(ExpensesModel expense) {
//     return expensesCollection
//         .doc(expense.id)
//         .set(expense.toJson())
//         // .add(client.toJson())
//         .then((value) =>
//             debugPrint("...............................client Added"))
//         .catchError((error) => debugPrint(
//             "////////////////////////////////////Failed to add client: $error"));
//   }

//   Future<void> editExpense(ExpensesModel expense) {
//     return expensesCollection
//         .doc(expense.id)
//         .update(expense.toJson())
//         // .add(client.toJson())
//         .then((value) =>
//             debugPrint("...............................client Added"))
//         .catchError((error) => debugPrint(
//             "////////////////////////////////////Failed to add client: $error"));
//   }

//   bool _loading = false;
//   bool get loading => _loading;
//   void setLoading(bool loading) {
//     _loading = loading;
//     notifyListeners();
//   }

//   String _selectedCategory = 'Raw Material';

//   String get selectedCategory => _selectedCategory;

//   void setCategory(String category) {
//     _selectedCategory = category;
//     notifyListeners();
//   }
// }




import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:girdhari/features/expenses/model/expenses_model.dart';

class ExpensesProvider with ChangeNotifier {
  List<ExpensesModel> _expenses = [];
  String _selectedCategory = 'Raw Material';
  bool _loading = false;
  double _totalPrice = 0;

  List<ExpensesModel> get expenses => _expenses;
  String get selectedCategory => _selectedCategory;
  bool get loading => _loading;
  double get totalPrice => _totalPrice;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> addExpenses(ExpensesModel expense) async {
    _loading = true;
    notifyListeners();

    try {
      await FirebaseFirestore.instance
          .collection("expensesStore")
          .doc(expense.id)
          .set(expense.toJson());
      _expenses.add(expense);
      _totalPrice += expense.amount;
      notifyListeners();
    } catch (error) {
      print("Error adding expense: $error");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchExpenses() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection("expensesStore").get();
      _expenses = snapshot.docs
          .map((doc) => ExpensesModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      _totalPrice = _expenses.fold(0, (sum, expense) => sum + expense.amount);
      notifyListeners();
    } catch (error) {
      print("Error fetching expenses: $error");
    }
  }
}
