import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:girdhari/features/expenses/model/expenses_model.dart';

class ExpensesController {

  final expensesCollection =
      FirebaseFirestore.instance.collection('expensesStore');

  Future<void> addExpenses(ExpensesModel expense) {
    return expensesCollection
        .doc(expense.id)
        .set(expense.toJson())
   
        .then((value) =>
            debugPrint("...............................client Added"))
        .catchError((error) => debugPrint(
            "////////////////////////////////////Failed to add client: $error"));
  }

  Future<void> editExpense(ExpensesModel expense) {
    return expensesCollection
        .doc(expense.id)
        .update(expense.toJson())
   
        .then((value) =>
            debugPrint("...............................client Added"))
        .catchError((error) => debugPrint(
            "////////////////////////////////////Failed to add client: $error"));
  }

  Future<void> deleteExpense(String id) {
    return expensesCollection
        .doc(id)
        .delete()
        .then((value) =>
            debugPrint("............................delete... Expense"))
        .catchError((error) => debugPrint(
            "////////////////////////////////////Failed to delete. Expense: $error"));
  }
}
