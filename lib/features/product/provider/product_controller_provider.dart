import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:girdhari/features/dashboard_screen.dart';
import 'package:girdhari/features/product/controller/product_controller.dart';
import 'package:girdhari/features/product/controller/product_date_controller.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/features/product/model/date_model.dart';
import 'package:girdhari/utils/utils.dart';


class ProductControllerProvider with ChangeNotifier {
  bool _addproductLoading = false;
  bool _editproductLoading = false;
  bool _deleteProductLoading = false;
  bool _flagZeroLoading = false;
  bool get addproductLoading => _addproductLoading;
  bool get editproductLoading => _editproductLoading;
  bool get deleteProductLoading => _deleteProductLoading;
  bool get flagZeroLoading => _flagZeroLoading;
  void setAddProductLoading(bool load) {
    _addproductLoading = load;
    notifyListeners();
  }

  void setDeleteProductLoading(bool load) {
    _deleteProductLoading = load;
    notifyListeners();
  }

  void setEditproductLoading(bool load) {
    _editproductLoading = load;
    notifyListeners();
  }

  void setflagZeroLoading(bool load) {
    _flagZeroLoading = load;
    notifyListeners();
  }

  void submitProduct(ProductModel product) async {
    await ProductController().addProduct(product).then((value) {
      setAddProductLoading(false);

      Utils().toastSuccessMessage('Product added successfully!');

      Get.to(() => const DashBoardScreen());
    }).catchError((error) {
      setAddProductLoading(false);

      Utils().toastErrorMessage("failed to add product");
    });
  }

  void editProduct(ProductModel product) async {
    await ProductController().editProduct(product).then((value) {
      setEditproductLoading(false);
      Utils().toastSuccessMessage('Product Edited Successfully!');
      Get.to(() => const DashBoardScreen());
    }).catchError((error) {
      setEditproductLoading(false);
      Utils().toastErrorMessage('Failed to Edit Product!');
    });
  }

  void flagZero(ProductModel product,DateModel flagZero) async {
    await ProductController().editProduct(product).then((value) {
      setflagZeroLoading(false);
      Utils().toastSuccessMessage('Product Edited Successfully!');
      ProductDateController().addProductDate(flagZero);
      Get.back();
    }).catchError((error) {
      setflagZeroLoading(false);
      Get.back();
      Utils().toastErrorMessage('Failed to Edit Product!');
    });
  }

  void deleteProduct(String product) async {
    await ProductController().deleteProduct(product).then((value) {
      setDeleteProductLoading(false);
      Utils().toastSuccessMessage('Product Deleted Successfully!');
      Get.back();
    }).catchError((error) {
      setDeleteProductLoading(false);
      Get.back();
      Utils().toastErrorMessage('Failed to Delete Product!');
    });
  }
}
