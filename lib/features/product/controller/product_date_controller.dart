import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:girdhari/features/product/model/date_model.dart';
import 'package:uuid/uuid.dart';

class ProductDateController {
  final dateCollection =
      FirebaseFirestore.instance.collection('productStockDate');

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


}
