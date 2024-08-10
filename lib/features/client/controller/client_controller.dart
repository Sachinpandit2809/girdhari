import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:girdhari/features/client/model/client_model.dart';

class ClientController {
  // final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');
  final clientsCollection =
      FirebaseFirestore.instance.collection('clientStore');

  Future<void> addClient(ClientModel client) {
    return clientsCollection
        .doc(client.id)
        .set(client.toJson())
        // .add(client.toJson())
        .then((value) =>
            debugPrint("...............................client Added"))
        .catchError((error) => debugPrint(
            "////////////////////////////////////Failed to add client: $error"));
  }

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

  Future<void> deleteClient(String id) {
    return clientsCollection
        .doc(id)
        .delete()
        .then((value) =>
            debugPrint("...............................client deleted"))
        .catchError((error) => debugPrint(
            "////////////////////////////////////Failed to deleted client: $error"));
  }
}
