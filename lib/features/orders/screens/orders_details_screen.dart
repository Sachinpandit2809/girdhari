import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/features/orders/controller/order_provider.dart';
import 'package:girdhari/features/orders/model/order_model.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/printer/lib/main.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:girdhari/widgets/common/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/common/lebel_k_text_form_field.dart';
import 'package:girdhari/widgets/common/rectangular_button.dart';
import 'package:girdhari/widgets/common/small_square_button.dart';
import 'package:girdhari/widgets/common/squre_icon_button.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OrdersDetailsScreen extends StatefulWidget {
  OrderModel order;
  List<BillingProductModel> orderProductList;
  ClientModel clientDetails;
  OrdersDetailsScreen(
      {super.key,
      required this.orderProductList,
      required this.clientDetails,
      required this.order});

  @override
  State<OrdersDetailsScreen> createState() => _OrdersDetailsScreenState();
}

class _OrdersDetailsScreenState extends State<OrdersDetailsScreen> {
  TextEditingController qtyController = TextEditingController();
  TextEditingController mrpController = TextEditingController();

  final fireStore =
      FirebaseFirestore.instance.collection('OrderStock').snapshots();
  final listDetails = FirebaseFirestore.instance.collection('productStore');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Order Details",
            style: KTextStyle.K_20,
          ),
          actions: [
            Consumer<ModifyBillProduct>(
                builder: (context, modifyBillProduct, _) {
              return FlexiableRectangularButton(
                  title: "\u{20B9} ${modifyBillProduct.totalPrice}",
                  textColor: Colors.black,
                  width: 130,
                  height: 30,
                  color: AppColor.skyBlueButton,
                  onPress: () {});
            })
          ],
        ),
        body: Consumer<ModifyBillProduct>(
            builder: (context, modifyBillProduct, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary,
                          offset: const Offset(0, 0),
                          blurRadius: 5,
                          spreadRadius: 0,
                          blurStyle: BlurStyle.outer,
                        )
                      ]),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //details
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            modifyBillProduct.clientModel.clientName,
                            style: KTextStyle.K_14,
                          ),
                          Text(
                            modifyBillProduct.clientModel.address,
                            style: KTextStyle.K_10,
                          ),
                        ],
                      ),
                      //figure
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RectangularButton(
                              title:
                                  "${widget.order.date.day}-${widget.order.date.month}-${widget.order.date.year}",
                              color: AppColor.yellow),
                          const SizedBox(
                            height: 4,
                          ),
                          RectangularButton(
                              title: widget.order.status.name,
                              color: widget.order.status.name == "Pending"
                                  ? AppColor.skyBlueButton
                                  : AppColor.green),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: modifyBillProduct.modifiedProductList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // if(widget.orderProductList[index].availableQuantity! -int.parse (qtyController.text)<0){
                              //                     Utils().toastErrorMessage(
                              //                         "Not sufficient stock Only ${widget.orderProductList[index].availableQuantity}");
                              //                     Get.back();
                              //                     return;
                              //                   }

                              if (modifyBillProduct.orderModel.status.name ==
                                  'Completed') {
                                Utils().toastErrorMessage(
                                    "Order allready Completed");
                                // Get.back();
                                return;
                              }
                              qtyController.text = modifyBillProduct
                                  .modifiedProductList[index].selectedQuantity
                                  .toString();
                              mrpController.text = modifyBillProduct
                                  .modifiedProductList[index].mrp
                                  .toString();
                              //mrpQty(widget.order,widget.clientDetails,widget.orderProductList);
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: SizedBox(
                                      height: 510,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              LebelKTextFormField(
                                                  label: "MRP",
                                                  controller: mrpController,
                                                  keyBoard:
                                                      TextInputType.number,
                                                  hintText: "Enter new mrp"),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              LebelKTextFormField(
                                                  label: "Quantity",
                                                  controller: qtyController,
                                                  keyBoard:
                                                      TextInputType.number,
                                                  hintText:
                                                      "Enter new quantity"),
                                              FlexiableRectangularButton(
                                                title: "CHANGE",
                                                width: 120,
                                                height: 44,
                                                // loading: loading,
                                                color: AppColor.brown,
                                                onPress: () {
                                                  if (modifyBillProduct
                                                          .orderModel
                                                          .status
                                                          .name ==
                                                      'Completed') {
                                                    Utils().toastErrorMessage(
                                                        "Order allready Completed");
                                                    Get.back();
                                                    return;
                                                  }
                                                  if (widget
                                                              .orderProductList[
                                                                  index]
                                                              .availableQuantity! -
                                                          int.parse(
                                                              qtyController
                                                                  .text) <
                                                      0) {
                                                    Utils().toastErrorMessage(
                                                        "Not sufficient stock Only ${widget.orderProductList[index].availableQuantity}");
                                                    Get.back();
                                                    return;
                                                  }

                                                  modifyBillProduct.ModifiedProductList(
                                                      BillingProductModel(
                                                          id: widget
                                                              .orderProductList[
                                                                  index]
                                                              .id,
                                                          time: widget
                                                              .orderProductList[
                                                                  index]
                                                              .time,
                                                          availableQuantity:
                                                              widget.orderProductList[index].availableQuantity! -
                                                                  int.parse(
                                                                      qtyController
                                                                          .text),
                                                          productName: widget
                                                              .orderProductList[
                                                                  index]
                                                              .productName,
                                                          skuCode: widget
                                                              .orderProductList[
                                                                  index]
                                                              .skuCode,
                                                          weight: widget
                                                              .orderProductList[
                                                                  index]
                                                              .weight,
                                                          packaging: widget
                                                              .orderProductList[
                                                                  index]
                                                              .packaging,
                                                          cost: widget
                                                              .orderProductList[
                                                                  index]
                                                              .cost,
                                                          wholesalePrice: widget
                                                              .orderProductList[index]
                                                              .wholesalePrice,
                                                          selectedQuantity: int.parse(qtyController.text),
                                                          mrp: double.parse(mrpController.text)),
                                                      index);
                                                  debugPrint(
                                                      "................||...............");
                                                  debugPrint(modifyBillProduct
                                                      .modifiedProductList
                                                      .toString());

                                                  modifyBillProduct
                                                      .calculateTotalOrderBill();
                                                  Get.back();
                                                },
                                              )
                                            ]),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 3),
                              margin: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                        child: Text(
                                          modifyBillProduct
                                              .modifiedProductList[index]
                                              .productName,
                                          style: KTextStyle.K_16,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          RectangularButton(
                                              title: modifyBillProduct
                                                  .modifiedProductList[index]
                                                  .packaging,
                                              color: AppColor.skyBlueButton),
                                          RectangularButton(
                                              title: modifyBillProduct
                                                  .modifiedProductList[index]
                                                  .weight,
                                              color: AppColor.yellowButton),
                                          SmallSquareButton(
                                              title: modifyBillProduct
                                                  .modifiedProductList[index]
                                                  .mrp
                                                  .toString(),
                                              color: AppColor.yellow),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FlexiableRectangularButton(
                                          textColor: Colors.black,
                                          title: modifyBillProduct
                                              .modifiedProductList[index]
                                              .selectedQuantity
                                              .toString(),
                                          width: 51,
                                          height: 46,
                                          onPress: () {},
                                          color: AppColor.skyBlueButton),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
                SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FlexiableRectangularButton(
                          title: "MARK COMPLETED",
                          width: 200,
                          height: 40,
                          color: AppColor.brown,
                          loading: modifyBillProduct.isLoading,
                          onPress: () {
                            if (modifyBillProduct.orderModel.status.name ==
                                'Completed') {
                              Utils().toastErrorMessage(
                                  "Order allready Completed");
                              // Get.back();
                              return;
                            }
                            modifyBillProduct.setLoading(true);
                            modifyBillProduct.uploadBillToFireBase(context);
                          }),
                      SqureIconButton(
                          icon: const Icon(Icons.print, color: AppColor.white),
                          color: AppColor.brown,
                          onPress: () {
                            debugPrint(
                                modifyBillProduct.clientModel.toString());
                            debugPrint(modifyBillProduct.modifiedProductList
                                .toString());
                            Get.to(() => const MyHomePage());
                           
                          })
                    ],
                  ),
                )
              ],
            ),
          );
        }));
  }
}
