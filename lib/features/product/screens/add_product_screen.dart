import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/features/product/provider/product_controller_provider.dart';

import 'package:girdhari/widgets/drop_down_text_form_field.dart';

import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/k_text_form_field.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController squCodeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController packagingController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController wholesalePriceController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  bool loading = false;
  final _addProductFormKey = GlobalKey<FormState>();

  final fireStore = FirebaseFirestore.instance.collection("users");

  @override
  void dispose() {
    mrpController.dispose();
    // packageController.dispose();
    wholesalePriceController.dispose();
    costController.dispose();
    packagingController.dispose();
    weightController.dispose();
    squCodeController.dispose();
    productNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Product",
          style: KTextStyle.K_20,
        ),
      ),
      body: Consumer<ProductControllerProvider>(
          builder: (context, productControllerProvider, _) {
        return SingleChildScrollView(
          child: Form(
            key: _addProductFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Text(
                      "Enter details",
                      style: KTextStyle.K_14,
                    ),
                  ),
                  KTextFormField(
                      validator: (value) {
                        if (productNameController.text.isEmpty) {
                          return "please enter product name ";
                        }
                        return null;
                      },
                      controller: productNameController,
                      hintText: "Product"),
                  KTextFormField(
                      validator: (value) {
                        if (squCodeController.text.isEmpty) {
                          return "please enter SKU code ";
                        }
                        return null;
                      },
                      controller: squCodeController,
                      hintText: "SKU Code"),
                  KTextFormField(
                      validator: (value) {
                        if (weightController.text.isEmpty) {
                          return "please enter weight/QTY ";
                        }
                        return null;
                      },
                      controller: weightController,
                      hintText: "Weight/Qty"),
                  DropDownTextFormField(
                      validator: (value) {
                        if (packagingController.text.isEmpty) {
                          return "please select Package ";
                        }
                        return null;
                      },
                      controller: packagingController,
                      hintText: "Packaging"),
                  KTextFormField(
                      validator: (value) {
                        if (costController.text.isEmpty) {
                          return "please enter cost";
                        }
                        return null;
                      },
                      controller: costController,
                      hintText: "Cost"),
                  KTextFormField(
                      validator: (value) {
                        if (wholesalePriceController.text.isEmpty) {
                          return "please enter wholesale price ";
                        }
                        return null;
                      },
                      controller: wholesalePriceController,
                      hintText: "Wholesale Price"),
                  KTextFormField(
                      validator: (value) {
                        if (mrpController.text.isEmpty) {
                          return "please enter MRP";
                        }
                        return null;
                      },
                      controller: mrpController,
                      hintText: "MRP"),
                  const SizedBox(height: 20),
                  Center(
                    child: FlexiableRectangularButton(
                      title: "SUBMIT",
                      width: 120,
                      loading: productControllerProvider.addproductLoading,
                      height: 44,
                      color: AppColor.brown,
                      onPress: () {
                        if (_addProductFormKey.currentState!.validate()) {
                          productControllerProvider.setAddProductLoading(true);
                          String id = const Uuid().v4();
                          String time =
                              "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
                          ProductModel product = ProductModel(
                            id: id,
                            time: time,
                            availableQuantity: 0,
                            productName: productNameController.text,
                            skuCode: squCodeController.text,
                            weight: weightController.text,
                            packaging: packagingController.text,
                            cost: double.parse(costController.text),
                            wholesalePrice:
                                double.parse(wholesalePriceController.text),
                            mrp: double.parse(mrpController.text),
                          );
                          productControllerProvider.submitProduct(product);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
