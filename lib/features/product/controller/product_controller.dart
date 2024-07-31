import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';

class ProductController {
  // final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');
  final productsCollection =
      FirebaseFirestore.instance.collection('productStock');

  Future<void> addProduct(ProductModel product) {
    return productsCollection
        .doc(product.id)
        .set(product.toJson())
        // .add(product.toJson())
        .then((value) =>
            debugPrint("...............................Product Added"))
        .catchError((error) => debugPrint(
            "////////////////////////////////////Failed to add product: $error"));
  }
}
