import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/features/orders/controller/order_controller.dart';
import 'package:girdhari/features/orders/model/order_model.dart';
import 'package:girdhari/features/orders/screens/orders_screen.dart';
import 'package:girdhari/features/product/controller/product_controller.dart';
import 'package:girdhari/features/product/controller/product_date_controller.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/features/product/model/date_model.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class OrderProvider with ChangeNotifier {
  ClientModel _clientModel = ClientModel(
      id: "dumyClientDeveloper",
      clientName: "dumyClientDeveloper",
      phoneNumber: 0000000000,
      address: "dumyClientDeveloper",
      referredBy: "dumyClientDeveloper");
  ClientModel get clientModel => _clientModel;
  bool _loading = false;
  bool get loading => _loading;
  bool _delloading = false;
  bool get delLoading => _delloading;
  void setCmfLoading(bool load) {
    _loading = load;
    notifyListeners();
  }

  void setDelLoading(bool load) {
    _delloading = load;
    notifyListeners();
  }

  void setClientModel(ClientModel model) {
    _clientModel = model;
    notifyListeners();
  }

  void deleteOrder(OrderModel order) {
    OrderController().deleteOrder(order).then((onValue) {
      Utils().toastSuccessMessage("order has been deleted");
      setDelLoading(false);
      Get.back();
    }).onError(
      (error, stackTrace) {
        Utils().toastSuccessMessage("order has been deleted");
        Get.back();
        setDelLoading(false);
      },
    );
  }
}

class SelectedProductProvider with ChangeNotifier {
  List<BillingProductModel> _selectedProducts = [];
  List<BillingProductModel> get selectedProducts => _selectedProducts;
  bool _selectedColor = false;
  bool get selectColor => _selectedColor;
  double totalPrice = 0;
  bool _loading = false;
  bool get loading => _loading;
  void setCmfLoading(bool load) {
    _loading = load;
    notifyListeners();
  }

  void calculateTotalOrder() {
    if (_selectedProducts.isNotEmpty) {
      totalPrice = 0;
      for (final product in _selectedProducts) {
        totalPrice += product.totalPrice;
      }
    }
  }

  void changeColor(bool color) {
    _selectedColor = color;
    notifyListeners();
  }

  void addProduct(BillingProductModel product) {
    if (!_selectedProducts.contains(product)) {
      _selectedProducts.add(product);
      calculateTotalOrder();
      notifyListeners();
    }
  }

  void removeProduct(ProductModel product) {
    _selectedProducts.remove(product);
    calculateTotalOrder();
    notifyListeners();
  }

  void clearProducts() {
    debugPrint(_selectedProducts.toString());

    _selectedProducts = [];
    totalPrice = 0;
    debugPrint(
        "...............................cleared.............................");
    debugPrint(_selectedProducts.toString());

    notifyListeners();
  }

  void increaseQuantity(int index) {
    _selectedProducts[index].increaseQuantity();
    calculateTotalOrder();
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    _selectedProducts[index].decreaseQuantity();
    calculateTotalOrder();
    notifyListeners();
  }

  Future<void> uploadToFirebase(BuildContext context) async {
    // Firebase logic to upload _selectedProducts list
    try {
      final clientDetails = Provider.of<OrderProvider>(context, listen: false);
      final addProduct =
          Provider.of<SelectedProductProvider>(context, listen: false);

      String id = const Uuid().v4();
      DateTime time = DateTime.now();
      if (clientDetails._clientModel.clientName == 'dumyClientDeveloper') {
        Utils().toastErrorMessage("No Client selected");
        clearProducts();
        setCmfLoading(false);
        return;
      }
      if (selectedProducts.isEmpty) {
        Utils().toastErrorMessage("please select minimum 1 product");
        clientDetails._clientModel = ClientModel(
            id: "dumyClientDeveloper",
            clientName: "dumyClientDeveloper",
            phoneNumber: 0000000000,
            address: "dumyClientDeveloper",
            referredBy: "dumyClientDeveloper");
        setCmfLoading(false);
        return;
      }

      OrderModel billing = OrderModel(
          id: id,
          client: clientDetails.clientModel,
          orderList: addProduct.selectedProducts,
          date: time);

      OrderController().addOrder(billing).then((onValue) {
        Utils().toastSuccessMessage("Order added");
        clearProducts();
        setCmfLoading(false);
        Get.to(const OrdersScreen());
      }).onError(
        (error, stackTrace) {
          clearProducts();
          setCmfLoading(false);
          Utils().toastErrorMessage("failed to add order");
        },
      );
    } catch (e) {
      Utils().toastSuccessMessage(e.toString());
    }
  }
}

class ModifyBillProduct with ChangeNotifier {
  List<BillingProductModel> _modifiedProductList = [];
  late ClientModel _clientModel;
  late OrderModel _orderModel;
  bool _isLoading = false;
  List<BillingProductModel> get modifiedProductList => _modifiedProductList;
  ClientModel get clientModel => _clientModel;
  OrderModel get orderModel => _orderModel;
  bool get isLoading => _isLoading;
  double totalPrice = 0;

  void setLoading(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  void calculateTotalOrderBill() {
    if (_modifiedProductList.isNotEmpty) {
      totalPrice = 0;
      for (final product in _modifiedProductList) {
        totalPrice += product.totalPrice;
      }
    }
  }

  // ignore: non_constant_identifier_names
  void ModifiedProductList(BillingProductModel orderProductList, int index) {
    if (index != -1) {
      _modifiedProductList[index] = orderProductList;
      // calculateTotalOrderBill();
      notifyListeners();
    }
  }

// seted the value of the order details for order Screen
  void setModifiedProductList(OrderModel order) {
    _modifiedProductList = order.orderList;
    _clientModel = order.client;
    _orderModel = order;
    calculateTotalOrderBill();
    notifyListeners();
  }

  void updateInMainProduct() async {
    // final ref = FirebaseFirestore.instance.collection("productStock");
    for (BillingProductModel product in _modifiedProductList) {
      ProductModel newProduct = ProductModel(
          totalPrice: product.wholesalePrice,
          id: product.id,
          time: product.time,
          availableQuantity:
              product.availableQuantity! - product.selectedQuantity,
          productName: product.productName,
          skuCode: product.skuCode,
          weight: product.weight,
          packaging: product.packaging,
          cost: product.cost,
          wholesalePrice: product.wholesalePrice,
          mrp: product.mrp);

      await ProductController().editProduct(newProduct);
      DateModel dateModel = DateModel(
          id: newProduct.id,
          date: DateTime.now().toIso8601String(),
          sellTag: "Retail",
          quantity: product.selectedQuantity);
      await ProductDateController().addProductDate(dateModel);
    }
  }

  Future<void> uploadBillToFireBase(BuildContext context) async {
    DateTime time = DateTime.now();

    OrderModel billing = OrderModel(
        status: OrderStatus.completed,
        id: orderModel.id,
        client: _clientModel,
        orderList: _modifiedProductList,
        date: time);
// this is the section for uploading the bill in ClientStore
    FirebaseFirestore.instance
        .collection('clientStore')
        .doc(orderModel.client.id)
        .collection("clientOrders")
        .add(billing.toJson());

    BillController().addBill(billing).then((onValue) {
      orderModel.status = OrderStatus.completed;
      updateInMainProduct();
      setLoading(false);
      Utils().toastSuccessMessage("Bill added");
      debugPrint(billing.orderList.toString());

      // Get.to(const OrdersScreen());
    }).onError(
      (error, stackTrace) {
        setLoading(false);
        Utils().toastErrorMessage("failed to add order");
      },
    );
  }
}
