import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:girdhari/features/orders/controller/bill_provider.dart';
import 'package:girdhari/features/orders/controller/order_controller.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:girdhari/widgets/common/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/common/lebel_k_text_form_field.dart';
import 'package:girdhari/widgets/common/rectangular_button.dart';
import 'package:girdhari/widgets/common/small_square_button.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  ProductCard(
      {super.key,
      required this.product,
      required this.qtyController,
      required this.wholesellPriceController});
  ProductModel product;
  TextEditingController wholesellPriceController;
  TextEditingController qtyController;
  // BillController billProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(top: 15),
      // height: 60,
      // width: 315,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          color: product.availableQuantity! > 0
              ? Theme.of(context).colorScheme.secondary
              : Colors.red.shade100,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  product.productName,
                  style: KTextStyle.K_16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RectangularButton(
                      title: product.packaging, color: AppColor.skyBlueButton),
                  RectangularButton(
                      title: product.weight, color: AppColor.yellowButton),
                  SmallSquareButton(
                      title: product.wholesalePrice.toString(),
                      color: AppColor.yellow),
                  SmallSquareButton(
                      title: product.availableQuantity.toString(),
                      color: AppColor.green),
                ],
              )
            ],
          ),
          Row(
            children: [
              FlexiableRectangularButton(
                  textColor: Colors.black,
                  title: product.totalPrice.toString(),
                  width: 51,
                  height: 46,
                  onPress: () {
                    qtyController.text = 1.toString();
                    wholesellPriceController.text =
                        product.wholesalePrice.toString();
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Consumer<BillProvider>(
                            builder: (context, billProvider, _) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              height: 510,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      LebelKTextFormField(
                                          label: "wholeSell",
                                          controller: wholesellPriceController,
                                          keyBoard: TextInputType.number,
                                          hintText: "Enter new mrp"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      LebelKTextFormField(
                                          label: "Quantity",
                                          controller: qtyController,
                                          keyBoard: TextInputType.number,
                                          hintText: "Enter new quantity"),
                                      FlexiableRectangularButton(
                                        title: "ADD",
                                        width: 120,
                                        height: 44,
                                        // loading: loading,
                                        color: AppColor.brown,
                                        onPress: () {
                                          if (product.availableQuantity! -
                                                  int.parse(
                                                      qtyController.text) <
                                              0) {
                                            Utils().toastErrorMessage(
                                                "not proper Stock available, Only ${product.availableQuantity}");
                                            Get.back();
                                            return;
                                          }
                                          var changedPrice =
                                              double.parse(qtyController.text) *
                                                  double.parse(
                                                      wholesellPriceController
                                                          .text);
                                          debugPrint(
                                              "changed price $changedPrice");
                                          BillingProductModel addProduct =
                                              BillingProductModel(
                                                  totalPrice: changedPrice,
                                                  id: product.id,
                                                  time: product.time,
                                                  availableQuantity:
                                                      product.availableQuantity,
                                                  productName:
                                                      product.productName,
                                                  skuCode: product.skuCode,
                                                  weight: product.weight,
                                                  packaging: product.packaging,
                                                  cost: product.cost,
                                                  wholesalePrice:
                                                      product.wholesalePrice,
                                                  selectedQuantity: int.parse(
                                                      qtyController.text),
                                                  mrp: product.mrp);
                                          debugPrint(addProduct.toString());
                                          billProvider
                                              .addInProductList(addProduct);
                                          Get.back();
                                        },
                                      )
                                      // ,FlexiableRectangularButton(
                                      //   title: "CHANGE",
                                      //   width: 120,
                                      //   height: 44,
                                      //   // loading: loading,
                                      //   color: AppColor.brown,
                                      //   onPress: () {
                                      //     // var changedPrice = double.parse(qtyController.text) * double.parse(wholesellPriceController.text);
                                      //     // debugPrint("changed price " + changedPrice.toString());
                                      //     // BillingProductModel addProduct = BillingProductModel(totalPrice: changedPrice, id: product.id, time: product.time, availableQuantity: product.availableQuantity, productName: product.productName, skuCode: product.skuCode, weight: product.weight, packaging: product.packaging, cost: product.cost, wholesalePrice: double.parse(wholesellPriceController.text), selectedQuantity: int.parse(qtyController.text), mrp: product.mrp);

                                      //     billProvider.removeInProductList();
                                      //   },
                                      // )
                                    ]),
                              ),
                            ),
                          );
                        });
                      },
                    );
                  },
                  color: AppColor.skyBlueButton),
              // SqureIconButton(
              //     icon:
              //         const Icon(
              //       Icons.close,
              //       color:
              //           AppColor.white,
              //       size:
              //           20,
              //     ),
              //     color: AppColor
              //         .brown,
              //     onPress:
              //         () {})
            ],
          ),
        ],
      ),
    );
  }
}
