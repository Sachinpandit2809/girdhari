import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girdhari/features/product/controller/edit_product_controller.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/features/product/screens/stock_record_screen.dart';
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

  final EditProductController _editProductController = EditProductController();

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

    await _editProductController.editProduct(product).then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastSuccessMessage('Product Edited Successfully!');

      Get.to(const StockRecordScreen());
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
                  controller: skuCodeController, hintText: "SKU Code"),
              KTextFormField(
                  controller: weightController, hintText: "Weight/Qty"),
              DropDownTextFormField(
                  controller: packagingController, hintText: "Packaging"),
              KTextFormField(controller: costController, hintText: "Cost"),
              KTextFormField(
                  controller: wholesalePriceController,
                  hintText: "Wholesale Price"),
              KTextFormField(controller: mrpController, hintText: "MRP"),
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
                      editProduct();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
