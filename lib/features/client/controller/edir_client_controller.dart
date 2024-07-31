import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/features/client/model/client_model.dart';

class EditClientController {
  // final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');
  final clientsCollection =
      FirebaseFirestore.instance.collection('clientStore');

  Future<void> editClient(ClientModel client) {
    return clientsCollection
        .doc(client.id)
        .update(client.toJson())
        // .add(client.toJson())
        .then((value) =>
            debugPrint("...............................client Added"))
        .catchError((error) => debugPrint(
            "////////////////////////////////////Failed to add client: $error"));
  }
}
