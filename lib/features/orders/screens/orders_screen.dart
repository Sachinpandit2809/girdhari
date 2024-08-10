import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/features/orders/controller/order_provider.dart';
import 'package:girdhari/features/orders/model/order_model.dart';
import 'package:girdhari/features/orders/screens/billing_screen.dart';
import 'package:girdhari/features/orders/screens/orders_details_screen.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:girdhari/widgets/flexiable_rectangular_button.dart';

import 'package:girdhari/widgets/rectangular_button.dart';

import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/widgets/search_k_textformfield.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // ignore: non_constant_identifier_names
  final firebaseSnapshot =
      FirebaseFirestore.instance.collection("OrderStore").snapshots();
  TextEditingController SearchClientController = TextEditingController();
  @override
  void dispose() {
    SearchClientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order",
          style: KTextStyle.K_20,
        ),
        // actions: [
        //   FlexiableRectangularButton(
        //       title: "\u{20B9} 5,00,00",
        //       textColor: Colors.black,
        //       width: 130,
        //       height: 30,
        //       color: AppColor.skyBlueButton,
        //       onPress: () {})
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchKTextformfield(
                onChange: (p0) {
                  setState(() {});
                },
                controller: SearchClientController,
                hintText: "Search Client"),
            StreamBuilder<QuerySnapshot>(
              stream: firebaseSnapshot,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  Utils().toastErrorMessage("error during communication");
                }

                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          OrderModel order = OrderModel.fromJson(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>);

                          if (SearchClientController.text.isEmpty) {
                            return InkWell(
                              onLongPress: () {
                                debugPrint("....................triggred");
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Consumer<OrderProvider>(
                                          builder: (context, orderProvider, _) {
                                        return AlertDialog(
                                          content: SizedBox(
                                            height: 100,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Text(
                                                    "are you sure want to delete"),
                                                FlexiableRectangularButton(
                                                    title: "delete",
                                                    width: 140,
                                                    height: 40,
                                                    color: AppColor.brownRed,
                                                    loading: orderProvider
                                                        .delLoading,
                                                    onPress: () {
                                                      orderProvider
                                                          .setDelLoading(true);

                                                      orderProvider.deleteOrder(
                                                          order.id);
                                                    })
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    });
                              },
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) =>
                                            OrdersDetailsScreen(
                                              clientDetails: order.client,
                                              orderProductList: order.orderList,
                                              order: order,
                                            )));
                                final g = Provider.of<ModifyBillProduct>(
                                    context,
                                    listen: false);
                                g.setModifiedProductList(order);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 4),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        offset: const Offset(0, 1),
                                        blurRadius: 6,
                                        spreadRadius: 0,
                                        blurStyle: BlurStyle.outer,
                                      )
                                    ]),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //details
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          order.client.clientName,
                                          style: KTextStyle.K_14,
                                        ),
                                        Text(
                                          order.client.address,
                                          style: KTextStyle.K_10,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        RectangularButton(
                                            title:
                                                '${order.date.day}-${order.date.month}-${order.date.year}',
                                            color: AppColor.yellow)
                                      ],
                                    ),
                                    //figure
                                    RectangularButton(
                                        onPress: () {
                                          debugPrint(order.status.name);
                                        },
                                        title: order.status.name,
                                        color: order.status.name == "Pending"
                                            ? AppColor.yellowButton
                                            : AppColor.green)
                                  ],
                                ),
                              ),
                            );
                          }

                          if (order.client.clientName.toLowerCase().contains(
                              SearchClientController.text.toLowerCase())) {
                            return InkWell(
                              onLongPress: () {
                                debugPrint("....................triggred");
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Consumer<OrderProvider>(
                                          builder: (context, orderProvider, _) {
                                        return AlertDialog(
                                          content: SizedBox(
                                            height: 100,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Text(
                                                    "are you sure want to delete"),
                                                FlexiableRectangularButton(
                                                    title: "delete",
                                                    width: 140,
                                                    height: 40,
                                                    color: AppColor.brownRed,
                                                    loading: orderProvider
                                                        .delLoading,
                                                    onPress: () {
                                                      orderProvider
                                                          .setDelLoading(true);

                                                      orderProvider.deleteOrder(
                                                          order.id);
                                                    })
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    });
                              },
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) =>
                                            OrdersDetailsScreen(
                                              clientDetails: order.client,
                                              orderProductList: order.orderList,
                                              order: order,
                                            )));
                                final g = Provider.of<ModifyBillProduct>(
                                    context,
                                    listen: false);
                                g.setModifiedProductList(order);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 4),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary, // Adjust opacity for a blush effect
                                        offset: const Offset(
                                            0, 1), // Move the shadow downwards
                                        blurRadius:
                                            6, // Adjust blur radius as needed
                                        spreadRadius:
                                            0, // Adjust spread radius as needed
                                        blurStyle: BlurStyle.outer,
                                      )
                                    ]),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //details
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          order.client.clientName,
                                          style: KTextStyle.K_14,
                                        ),
                                        Text(
                                          order.client.address,
                                          style: KTextStyle.K_10,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        RectangularButton(
                                            title:
                                                '${order.date.day}-${order.date.month}-${order.date.year}',
                                            color: AppColor.yellow)
                                      ],
                                    ),
                                    //figure
                                    RectangularButton(
                                        onPress: () {
                                          debugPrint(order.status.name);
                                        },
                                        title: order.status.name,
                                        color: order.status.name == "Pending"
                                            ? AppColor.yellowButton
                                            : AppColor.green)
                                  ],
                                ),
                              ),
                            );
                          }
                          return Container();
                        }));
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.brown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: () {
          Get.to(const BillingScreen());
        },
        child: const Icon(
          Icons.add,
          color: AppColor.white,
          size: 30,
        ),
      ),
    );
  }
}
