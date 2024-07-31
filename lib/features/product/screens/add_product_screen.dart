// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
// import 'package:girdhari/widgets/k_text_form_field.dart';
// import 'package:girdhari/resource/app_color.dart';
// import 'package:girdhari/resource/k_text_style.dart';
// import 'package:girdhari/features/product/screens/edit_product_screen.dart';

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});

//   @override
//   State<AddProductScreen> createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   TextEditingController productNameController = TextEditingController();
//   TextEditingController squCodeController = TextEditingController();

//   TextEditingController weightController = TextEditingController();
//   TextEditingController packagingController = TextEditingController();
//   TextEditingController costController = TextEditingController();
//   TextEditingController wholesalePriceController = TextEditingController();
//   TextEditingController mrpController = TextEditingController();
//   TextEditingController packageController = TextEditingController();

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     mrpController.dispose();
//     packageController.dispose();
//     wholesalePriceController.dispose();
//     costController.dispose();
//     packagingController.dispose();
//     weightController.dispose();
//     squCodeController.dispose();
//     productNameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Add Product",
//           style: KTextStyle.K_20,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
//                 child: Text(
//                   "Enter details",
//                   style: KTextStyle.K_14,
//                 ),
//               ),
//               KTextFormField(
//                   controller: productNameController, hintText: "Product"),
//               KTextFormField(
//                   controller: squCodeController, hintText: "SKU Code"),
//               KTextFormField(
//                   controller: weightController, hintText: "Weight/Qty"),
//               KTextFormField(
//                   controller: packagingController, hintText: "Packaging"),
//               KTextFormField(controller: costController, hintText: "Cost"),
//               KTextFormField(
//                   controller: wholesalePriceController,
//                   hintText: "Wholesale Price"),
//               KTextFormField(controller: mrpController, hintText: "MRP"),
//               KTextFormField(
//                   controller: packageController, hintText: "Packaging"),
//               const SizedBox(
//                 height: 20,
//               ),
//               Center(
//                 child: FlexiableRectangularButton(
//                   title: "SUBMIT",
//                   width: 120,
//                   height: 44,
//                   color: AppColor.brown,
//                   onPress: () {

//                     Get.to(const EditProductScreen());
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/features/product/controller/product_controller.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/features/product/screens/stock_record_screen.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:girdhari/widgets/drop_down_text_form_field.dart';

import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/k_text_form_field.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/features/product/screens/edit_product_screen.dart';
// import 'package:your_project/controllers/product_controller.dart';
// import 'package:your_project/models/product_model.dart';
// import 'package:uuid/uuid.dart';

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

  final ProductController _productController = ProductController();
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

  void _submitProduct() async {
    setState(() {
      loading = true;
    });
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    ProductModel product = ProductModel(
      id: id,
      productName: productNameController.text,
      skuCode: squCodeController.text,
      weight: weightController.text,
      packaging: packagingController.text,
      cost: double.parse(costController.text),
      wholesalePrice: double.parse(wholesalePriceController.text),
      mrp: double.parse(mrpController.text),
    );

    await _productController.addProduct(product).then((value) {
      setState(() {
        loading = false;
      });
      
      Utils().toastSuccessMessage('Product added successfully!');

      Get.to(const StockRecordScreen());
    }).catchError((error) {
      setState(() {
        loading = false;
      });
      Utils().toastErrorMessage("failed to add product");
    });
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
              DropDownTextFormField(
                  controller: packagingController, hintText: "Packaging"),
              KTextFormField(controller: costController, hintText: "Cost"),
              KTextFormField(
                  controller: wholesalePriceController,
                  hintText: "Wholesale Price"),
              KTextFormField(controller: mrpController, hintText: "MRP"),
              // KTextFormField(
              //     controller: packageController, hintText: "Packaging"),
              const SizedBox(height: 20),
              Center(
                child: FlexiableRectangularButton(
                  title: "SUBMIT",
                  width: 120,
                  loading: loading,
                  height: 44,
                  color: AppColor.brown,
                  onPress: _submitProduct,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
