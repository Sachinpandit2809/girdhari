import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/k_text_form_field.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/features/product/screens/edit_product_screen.dart';

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
  TextEditingController packageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    mrpController.dispose();
    packageController.dispose();
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
      body: SingleChildScrollView(
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
                  controller: productNameController, hintText: "Product"),
              KTextFormField(
                  controller: squCodeController, hintText: "SKU Code"),
              KTextFormField(
                  controller: weightController, hintText: "Weight/Qty"),
              KTextFormField(
                  controller: packagingController, hintText: "Packaging"),
              KTextFormField(controller: costController, hintText: "Cost"),
              KTextFormField(
                  controller: wholesalePriceController,
                  hintText: "Wholesale Price"),
              KTextFormField(controller: mrpController, hintText: "MRP"),
              KTextFormField(
                  controller: packageController, hintText: "Packaging"),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: FlexiableRectangularButton(
                  title: "SUBMIT",
                  width: 120,
                  height: 44,
                  color: AppColor.brown,
                  onPress: () {
                   
                    Get.to(const EditProductScreen());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
