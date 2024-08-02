import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/features/product/model/date_model.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:uuid/uuid.dart';

class ProductDateController {
  final dateCollection =
      FirebaseFirestore.instance.collection('productStockDate');

  // Future<void> editProductDate(DateModel product) {
  //  final   dateCollectionDetails =dateCollection.collection("collectionPath");
  //    return  dateCollectionDetails.doc("sac").set(product.toJson())
  //       // .add(product.toJson())
  //       .then((value) =>
  //           debugPrint("...............................Product Edited"))
  //       .catchError((error) => debugPrint(
  //           "////////////////////////////////////Failed to Edit product: $error"));
  // }

  Future<void> addProductDate(DateModel product) async {

    final dateCollectionDetails =
        dateCollection.doc(product.id).collection("stockDateList");
    final docId = const Uuid().v4();

    try {
      await dateCollectionDetails.doc(docId).set(product.toJson());
      debugPrint("...............................Product Edited");
    } catch (error) {
      debugPrint(
          "////////////////////////////////////Failed to Edit product: $error");
    }
  }

  // Future<void> addProductDate(DateModel productDate) {
  //   return dateCollection
  //       .doc(productDate.id)
  //       .set(productDate.toJson())
  //
  //       .then((value) => Utils().toastSuccessMessage("Date Added"))
  //       .catchError((error) => debugPrint(
  //           "////////////////////////////////////Failed to Edit productDate: $error"));
  // }
}
