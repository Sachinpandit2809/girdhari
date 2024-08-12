import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/features/orders/controller/order_controller.dart';
import 'package:girdhari/features/orders/model/order_model.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:uuid/uuid.dart';

class BillProvider with ChangeNotifier {
  int orderNo = 1;
  List<ProductModel> _products = [];
  List<ClientModel> _clients = [];
  List<BillingProductModel> _selectedProductList = [];
  ClientModel selectedClient = ClientModel(
      id: "dummy",
      clientName: "dummy",
      phoneNumber: 0000000000,
      address: "dummy",
      referredBy: "dummy");
  bool _isConfermLoading = false;
  bool get isConfermLoading => _isConfermLoading;
  void setConfermLoading(bool loading) {
    _isConfermLoading = loading;
    notifyListeners();
  }

  void setClient(ClientModel client) {
    selectedClient = client;
    notifyListeners();
  }

  void removeClient() {
    selectedClient = ClientModel(
        id: "dummy",
        clientName: "dummy",
        phoneNumber: 0000000000,
        address: "dummy",
        referredBy: "dummy");
    
    debugPrint(selectedClient.toString());
    notifyListeners();
  }

  void addInProductList(BillingProductModel product) {
    if (!_selectedProductList.contains(product)) {
      _selectedProductList.add(product);
      debugPrint("..............................................." +
          product.totalPrice.toString());
      debugPrint(_selectedProductList.toString());
      notifyListeners();
    }
  }

  void removeInProductList(BillingProductModel product) {
    if (_selectedProductList.contains(product)) {
      _selectedProductList.remove(product);
      debugPrint(_selectedProductList.toString());

      notifyListeners();
    }
  }

  void emptyProductList() {
    _selectedProductList = [];
    debugPrint(_selectedProductList.toString());

    notifyListeners();
  }

  Stream<List<ProductModel>> fetchProducts() async* {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('productStock').get();
      _products = snapshot.docs.map((doc) =>
          // ignore: unnecessary_cast
          ProductModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
      notifyListeners();
      yield _products;
    } catch (e) {
      debugPrint("error fetching expenses $e");
    }
  }

  Stream<List<ClientModel>> fetchClient() async* {
    try {
      final snapShot =
          await FirebaseFirestore.instance.collection('clientStore').get();
      _clients = snapShot.docs.map((doc) =>
          // ignore: unnecessary_cast
          ClientModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
      notifyListeners();
      yield _clients;
    } catch (e) {
      debugPrint("error fetching expenses $e");
    }
  }

  void createOrder() async {
    setConfermLoading(true);

    if (selectedClient.clientName == 'dummy') {
      Utils().toastErrorMessage("please select client");
      setConfermLoading(false);
      return;
    }
    if (_selectedProductList.isEmpty) {
      Utils().toastErrorMessage("please select atleast 1 product");
      setConfermLoading(false);

      return;
    }

    String orderId = "ws00$orderNo";
    String date = DateTime.now().toIso8601String();
    // ClientModel client = ClientModel(id: selectedClient.id, clientName:selectedClient.clientName, phoneNumber:selectedClient.phoneNumber, address:selectedClient.address, referredBy:selectedClient.referredBy)
    OrderModel order = OrderModel(
        // id: Uuid().v4(),
        id: orderId,
        client: selectedClient,
        orderList: _selectedProductList,
        date: DateTime.now());
    OrderController().addOrder(order).then((onValue) {
      Utils().toastSuccessMessage("order added");
      setConfermLoading(false);
      orderNo += 1;
      emptyProductList();
      removeClient();
      Get.back();
    }).onError(
      (error, stackTrace) {
        Utils().toastErrorMessage(error.toString());
        setConfermLoading(false);
        emptyProductList();
        removeClient();
        Get.back();
      },
    );
  }
}
