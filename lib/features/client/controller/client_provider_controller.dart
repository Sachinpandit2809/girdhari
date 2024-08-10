import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girdhari/features/client/controller/client_controller.dart';
import 'package:girdhari/utils/utils.dart';

class ClientProviderController with ChangeNotifier {
  bool _isloading = false;
  bool get loading => _isloading;
  void setLoading(bool laod) {
    _isloading = laod;
    notifyListeners();
  }

  void deleteClient(String id) async {
    await ClientController().deleteClient(id).then((onValue) {
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
}
