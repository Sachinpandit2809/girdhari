import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';

class ProductController {
  final productsCollection =
      FirebaseFirestore.instance.collection('productStock');

  Future<void> addProduct(ProductModel product) {
    return productsCollection
        .doc(product.id)
        .set(product.toJson())
        .then((value) =>
            debugPrint("...............................Product Added"))
        .catchError((error) => debugPrint(
            "////////////////////////////////////Failed to add product: $error"));
  }

  Future<void> editProduct(ProductModel product) {
    return productsCollection
        .doc(product.id)
        .update(product.toJson())
        .then((value) =>
            debugPrint("...............................Product Edited"))
        .catchError((error) => debugPrint(
            "////////////////////////////////////Failed to Edit product: $error"));
  }

  Future<void> deleteProduct(String id) {
    return productsCollection
        .doc(id)
        .delete()
        .then((value) =>
            debugPrint("...............................Product deleted"))
        .catchError((error) => debugPrint(
            "////////////////////////////////////Failed to Product product: $error"));
  }
}
