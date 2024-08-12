import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girdhari/features/client/controller/client_controller.dart';
import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/features/orders/model/order_model.dart';
import 'package:girdhari/utils/utils.dart';

class ClientProviderController with ChangeNotifier {
  bool _isloading = false;
  bool get loading => _isloading;
  void setLoading(bool laod) {
    _isloading = laod;
    notifyListeners();
  }

  void deleteClient(ClientModel client) async {
    await ClientController().editClient(client).then((onValue) {
      setLoading(false);
      Get.back();
      Utils().toastSuccessMessage("client deleted");
    }).onError(
      (error, stackTrace) {
        setLoading(false);
        Get.back();

        Utils().toastErrorMessage("client deleted");
      },
    );
  }

  late ClientModel _client;
  ClientModel get client => _client;
  void setClient(ClientModel client) {
    _client = client;
  }

  List<OrderModel> _orderList = [];
  List<OrderModel> get orderList => _orderList;
  // double _totalBillAmount = 0;
  // double get totalBillAmount => _totalBillAmount;
  double _totalBillAmount = 0;
  double get totalBillAmount => _totalBillAmount;
  void calculateTotalBillAmount() {
    if (_orderList.isNotEmpty) {
      _totalBillAmount = 0;
      for (OrderModel i in _orderList) {
        _totalBillAmount += i.totalAmount.toDouble();
      }
    }
  }

  Stream<List<OrderModel>> fetchClientOrder() async* {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("clientStore")
          .doc(client.id)
          .collection("clientOrders")
          .get();
      _orderList = snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      _totalBillAmount = _orderList.fold(
          0, (result, billAmount) => result + billAmount.totalAmount);
      notifyListeners();
      yield _orderList;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List<ClientPaymentModel> _paymentList = [];
  List<ClientPaymentModel> get paymentList => _paymentList;
  // double _totalPaymentAmount = 0;
  // double get totalPaymentAmount => _totalPaymentAmount;
  double _totalPaymentAmount = 0;
  double get totalPaymentAmount => _totalPaymentAmount;
  void calculatePaymentAmount() {
    if (_paymentList.isNotEmpty) {
      _totalPaymentAmount = 0;
      for (ClientPaymentModel i in _paymentList) {
        _totalPaymentAmount += i.paymentAmount.toDouble();
      }
      notifyListeners();
    }
  }

  Stream<List<ClientPaymentModel>> fetchPaymentDetails() async* {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("clientStore")
          .doc(client.id)
          .collection('clientPaymentsDate')
          // .orderBy('date', descending: true)
          .get();
      _paymentList = snapshot.docs
          .map((doc) =>
              ClientPaymentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      // _totalPaymentAmount = _paymentList.fold(
      //     0, (result, payment) => result + payment.paymentAmount);
      calculatePaymentAmount();
      yield _paymentList;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(
      BuildContext context, TextEditingController _dateController) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      notifyListeners();
    }
  }

  bool _paymentLoading = false;
  bool get paymentLoading => _paymentLoading;
  void setPaymentLoading(bool load) {
    _paymentLoading = load;
    notifyListeners();
  }

  void addPayment(ClientPaymentModel paymentModel, ClientModel client) async {
    FirebaseFirestore.instance
        .collection('clientStore')
        .doc(client.id)
        .collection("clientPaymentsDate")
        .add(paymentModel.toJson())
        .then((value) {
      Utils().toastSuccessMessage('payment added');
      setPaymentLoading(false);
      Get.back();
    }).onError(
      (error, stackTrace) {
        setPaymentLoading(false);

        Utils().toastErrorMessage(error.toString());
        Get.back();
      },
    );
  }
}
