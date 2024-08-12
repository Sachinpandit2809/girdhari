import 'package:flutter/material.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/features/product/provider/product_controller_provider.dart';
import 'package:girdhari/widgets/common/drop_down_text_form_field.dart';
import 'package:girdhari/widgets/common/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/common/k_text_form_field.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel product;

  const EditProductScreen({
    super.key,
    required this.product,
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

  @override
  void initState() {
    super.initState();
    productNameController.text = widget.product.productName;
    skuCodeController.text = widget.product.skuCode;
    weightController.text = widget.product.weight;
    packagingController.text = widget.product.packaging;
    costController.text = widget.product.cost.toString();
    wholesalePriceController.text = widget.product.wholesalePrice.toString();
    mrpController.text = widget.product.mrp.toString();
    // packageController.text = widget.product.containsKey('package') ? widget.product['package'] ?? '' : '';
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
        title:  Text(
          "Edit Product",
          style: KTextStyle.K_20,
        ),
      ),
      body: Consumer<ProductControllerProvider>(
          builder: (context, productControllerProvider, _) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
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
                        loading: productControllerProvider.editproductLoading,
                        width: 120,
                        height: 44,
                        color: AppColor.brown,
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            productControllerProvider
                                .setEditproductLoading(true);
                            ProductModel product = ProductModel(
                              id: widget.product.id,
                            totalPrice:double.parse(wholesalePriceController.text) ,

                              time: widget.product.time,
                              availableQuantity:
                                  widget.product.availableQuantity,
                              productName: productNameController.text,
                              skuCode: skuCodeController.text,
                              weight: weightController.text,
                              packaging: packagingController.text,
                              cost: double.parse(costController.text),
                              wholesalePrice:
                                  double.parse(wholesalePriceController.text),
                              mrp: double.parse(mrpController.text),
                            );
                            productControllerProvider.editProduct(product);
                          }
                        }),
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
