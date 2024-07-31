import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';

class EditProductController {
  final productsCollection =
      FirebaseFirestore.instance.collection('productStock');

  Future<void> editProduct(ProductModel product) {
    return productsCollection
        .doc(product.id)
        .update(product.toJson())
        // .add(product.toJson())
        .then((value) =>
            debugPrint("...............................Product Edited"))
        .catchError((error) => debugPrint(
            "////////////////////////////////////Failed to Edit product: $error"));
  }
}
