import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:girdhari/features/orders/model/order_model.dart';

class OrderController {
 
  final orderCollection = FirebaseFirestore.instance.collection('OrderStore');

  Future<void> addOrder(OrderModel order) {
    return orderCollection
        .doc(order.id)
        .set(order.toJson())
  
        .then(
            (value) => debugPrint("...............................order Added"))
        .catchError((error) => debugPrint(
            "////////////////////////////////////Failed to add order: $error"));
  }
}

class BillController {
  //Billing
  final billingCollection = FirebaseFirestore.instance.collection('OrderStore');

  Future<void> addBill(OrderModel order) {
    return billingCollection
        .doc(order.id)
        .update(order.toJson())

        .then(
            (value) => debugPrint("..........Bill Added"))
        .catchError((error) => debugPrint("Failed to add Bill: $error"));
  }
}
