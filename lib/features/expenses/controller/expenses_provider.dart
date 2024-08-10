import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:girdhari/features/expenses/controller/expenses_controller.dart';
import 'package:girdhari/features/expenses/model/expenses_model.dart';
import 'package:girdhari/utils/utils.dart';


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

  void setLoading(bool load) {
    _loading = load;
    notifyListeners();
  }

  bool _deleteLoading = false;
  bool get deleteLoading => _deleteLoading;
  void setDeleteLoading(bool load) {
    _deleteLoading = load;
    notifyListeners();
  }

  void deleteExpense(String id) async {
   
    await ExpensesController().deleteExpense(id).then((onValue) {
      Utils().toastSuccessMessage("successfully  deleted");
      setDeleteLoading(false);
      Get.back();
    }).onError(
      (error, stackTrace) {
        Utils().toastSuccessMessage("successfully  deleted");
        setDeleteLoading(false);
        Get.back();
      },
    );
  }

  void addExpenses(ExpensesModel expense) async {
    await ExpensesController().addExpenses(expense).then((onValue) {
      Utils().toastSuccessMessage("expenses added");
      setLoading(false);
      Get.back();
    }).onError(
      (error, stackTrace) {
        setLoading(false);

        Utils().toastErrorMessage(error.toString());
      },
    );
  }

  Stream<List<ExpensesModel>> fetchExpenses() async* {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("expensesStore").get();
      _expenses = snapshot.docs
          .map((doc) =>
              // ignore: unnecessary_cast
              ExpensesModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      _totalPrice = _expenses.fold(0, (result, expense) => result + expense.amount);
      notifyListeners();
      yield _expenses;
    } catch (error) {
      debugPrint("Error fetching expenses: $error");
    }
  }
}
