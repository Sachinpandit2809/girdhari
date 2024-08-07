import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:girdhari/features/orders/model/order_model.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';

class OrderController {
  // final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');
  final orderCollection = FirebaseFirestore.instance.collection('OrderStore');

  Future<void> addOrder(OrderModel order) {
    return orderCollection
        .doc(order.id)
        .set(order.toJson())
        // .add(client.toJson())
        .then(
            (value) => debugPrint("...............................order Added"))
        .catchError((error) => debugPrint(
            "////////////////////////////////////Failed to add order: $error"));
  }

  Future<void> editClient(BillingProductModel order) {
    return orderCollection
        .doc(order.id)
        .set(order.toJson())
        // .add(client.toJson())
        .then((value) =>
            debugPrint("...............................order edited"))
        .catchError((error) => debugPrint(
            "////////////////////////////////////Failed to edit order: $error"));
  }
}

class BillController {
  //Billing
  final billingCollection = FirebaseFirestore.instance.collection('OrderStore');

  Future<void> addBill(OrderModel order) {
    return billingCollection
        .doc(order.id)
        .update(order.toJson())
        // .add(client.toJson())
        .then(
            (value) => debugPrint("...............................Bill Added"))
        .catchError((error) => debugPrint("Failed to add Bill: $error"));
  }
}
