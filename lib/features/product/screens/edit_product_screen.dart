import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girdhari/features/dashboard_screen.dart';
import 'package:girdhari/features/product/controller/product_controller.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:girdhari/widgets/drop_down_text_form_field.dart';
import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/k_text_form_field.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel data;

  const EditProductScreen({
    super.key,
    required this.data,
  });

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController skuCodeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController packagingController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController wholesalePriceController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  TextEditingController packageController = TextEditingController();
  bool loading = false;
  int? availableQty;

  final ProductController _productController = ProductController();

  @override
  void initState() {
    super.initState();
    productNameController.text = widget.data.productName;
    skuCodeController.text = widget.data.skuCode;
    weightController.text = widget.data.weight;
    packagingController.text = widget.data.packaging;
    costController.text = widget.data.cost.toString();
    wholesalePriceController.text = widget.data.wholesalePrice.toString();
    mrpController.text = widget.data.mrp.toString();
    // packageController.text = widget.data.containsKey('package') ? widget.data['package'] ?? '' : '';
  }

  editProduct() async {
    String id = widget.data.id;
    String time = widget.data.time;

    ProductModel product = ProductModel(
      id: id,
      time: time,
      availableQuantity: widget.data.availableQuantity,
      productName: productNameController.text,
      skuCode: skuCodeController.text,
      weight: weightController.text,
      packaging: packagingController.text,
      cost: double.parse(costController.text),
      wholesalePrice: double.parse(wholesalePriceController.text),
      mrp: double.parse(mrpController.text),
    );

    await _productController.editProduct(product).then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastSuccessMessage('Product Edited Successfully!');

      Get.to(const DashBoardScreen());
    }).catchError((error) {
      setState(() {
        loading = false;
      });
      Utils().toastErrorMessage('Failed to Edit Product!');
    });
  }

  @override
  void dispose() {
    mrpController.dispose();
    packageController.dispose();
    wholesalePriceController.dispose();
    costController.dispose();
    packagingController.dispose();
    weightController.dispose();
    skuCodeController.dispose();
    productNameController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Product",
          style: KTextStyle.K_20,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                      if (skuCodeController.text.isEmpty) {
                        return "please enter SKU Code";
                      }
                      return null;
                    },
                    controller: skuCodeController,
                    hintText: "SKU Code"),
                KTextFormField(
                    validator: (value) {
                      if (weightController.text.isEmpty) {
                        return "please enter weight/QTY";
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
                        return "please enter wholesale price";
                      }
                      return null;
                    },
                    controller: wholesalePriceController,
                    hintText: "Wholesale Price"),
                KTextFormField(
                    validator: (value) {
                      if (mrpController.text.isEmpty) {
                        return "please enter mrp";
                      }
                      return null;
                    },
                    controller: mrpController,
                    hintText: "MRP"),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: FlexiableRectangularButton(
                      title: "SUBMIT",
                      loading: loading,
                      width: 120,
                      height: 44,
                      color: AppColor.brown,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          editProduct();
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
