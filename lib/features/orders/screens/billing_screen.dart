import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/features/orders/controller/order_provider.dart';

import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/rectangular_button.dart';
import 'package:girdhari/widgets/search_k_textformfield.dart';
import 'package:girdhari/widgets/small_square_button.dart';
import 'package:girdhari/widgets/squre_icon_button.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';

import 'package:provider/provider.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  TextEditingController searchClientController = TextEditingController();

  TextEditingController searchProductController = TextEditingController();
  final clientSnapshot =
      FirebaseFirestore.instance.collection("clientStore").snapshots();
  final fireStore =
      FirebaseFirestore.instance.collection('productStock').snapshots();

  @override
  void dispose() {
    searchClientController.dispose();
    searchProductController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Billing",
          style: KTextStyle.K_20,
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                final addProduct = Provider.of<SelectedProductProvider>(context,
                    listen: false);
                addProduct.clearProducts();
                searchClientController.text = "";
                searchProductController.text = "";
              },
              child: Text(
                "Reset",
                style: KTextStyle.K_13.copyWith(color: AppColor.brown),
              )),
          Consumer<SelectedProductProvider>(
              builder: (context, selectedProductProvider, _) {
            return FlexiableRectangularButton(
                title: "Conferm",
                width: 75,
                height: 30,
                color: AppColor.brown,
                loading: selectedProductProvider.loading,
                onPress: () {
                  selectedProductProvider.setCmfLoading(true);
                  selectedProductProvider.uploadToFirebase(context);
                  searchClientController.text = "";
                  searchProductController.text = "";
                });
          })
        ],
      ),
      body: Consumer2<OrderProvider, SelectedProductProvider>(
          builder: (context, orderProvider, selectedProductProvider, _) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchKTextformfield(
                  onChange: (p0) {
                    setState(() {});
                  },
                  controller: searchClientController,
                  hintText: "Search Client"),
              StreamBuilder<QuerySnapshot>(
                stream: clientSnapshot,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    Utils().toastErrorMessage("error during connection");
                  }
                  //TODO searchable_DropDown
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        ClientModel searchClient = ClientModel.fromJson(
                            snapshot.data!.docs[index].data()
                                as Map<String, dynamic>);

                        if (searchClientController.text.isEmpty) {
                          return Container();
                        }

                        if (searchClient.clientName.toLowerCase().contains(
                                searchClientController.text.toLowerCase()) ||
                            searchClient.address.toLowerCase().contains(
                                searchClientController.text.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              searchClientController.text =
                                  searchClient.clientName;
                              orderProvider.setClientModel(searchClient);
                              debugPrint(orderProvider.toString());
                              debugPrint(selectedProductProvider
                                  .selectedProducts
                                  .toString());
                              searchProductController.text = '';
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              margin: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors
                                          .black45, // Adjust opacity for a blush effect
                                      offset: Offset(
                                          0, 5), // Move the shadow downwards
                                      blurRadius:
                                          10, // Adjust blur radius as needed
                                      spreadRadius:
                                          2, // Adjust spread radius as needed
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        searchClient.clientName,
                                        style: KTextStyle.K_14,
                                      ),
                                      Text(
                                        searchClient.address,
                                        style: KTextStyle.K_10,
                                      ),
                                    ],
                                  ),
                                  //figure
                                  SqureIconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: AppColor.white,
                                        size: 20,
                                      ),
                                      color: AppColor.brown,
                                      onPress: () {
                                        selectedProductProvider.clearProducts();
                                        searchClientController.text = "";
                                        searchProductController.text = "";
                                      })
                                ],
                              ),
                            ),
                          );
                        }

                        return Container();
                      },
                    ),
                  );
                },
              ),
              SearchKTextformfield(
                  onChange: (p0) {
                    setState(() {});
                  },
                  controller: searchProductController,
                  hintText: "Search Product"),
              StreamBuilder<QuerySnapshot>(
                stream: fireStore,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    Utils().toastErrorMessage("error during connection");
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        ProductListModel searchProduct =
                            ProductListModel.fromJson(snapshot.data!.docs[index]
                                .data() as Map<String, dynamic>);
                        // if (searchProductController.text.isEmpty) {
                        //   return Container();
                        // }
                        if (searchProduct.productModel.productName
                            .toLowerCase()
                            .contains(
                                searchProductController.text.toLowerCase())) {
                          // bool selectedColor = false;
                          return InkWell(
                            onTap: () {
                              BillingProductModel bill =
                                  BillingProductModel.fromProduct(
                                      searchProduct.productModel);

                              selectedProductProvider.addProduct(bill);
                              if (selectedProductProvider.selectedProducts
                                  .contains(bill)) {
                                debugPrint(
                                    " &&&&&&&&&&&&&&&&&&avalable in list show true");
                              }

                              debugPrint(selectedProductProvider
                                  .selectedProducts
                                  .toString());

                              // debugPrint(selectedProductProvider.selectColor
                              //     .toString());
                              // setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 3),
                              margin: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  color: (searchProduct
                                              .productModel.availableQuantity! >
                                          0)
                                      ? (Theme.of(context)
                                          .colorScheme
                                          .secondary)
                                      : Colors.red.shade100,

                                  // color: selectedProductProvider.selectedProducts.contains(
                                  //         searchProduct.productModel)
                                  //     ? AppColor.green
                                  //     : AppColor.grey,
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
                                          searchProduct
                                              .productModel.productName,
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
                                              title: searchProduct
                                                  .productModel.packaging,
                                              color: AppColor.skyBlueButton),
                                          RectangularButton(
                                              title: searchProduct
                                                  .productModel.weight,
                                              color: AppColor.yellowButton),
                                          SmallSquareButton(
                                              title: searchProduct
                                                  .productModel.wholesalePrice
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
                                          title: searchProduct
                                              .productModel.availableQuantity
                                              .toString(),
                                          width: 51,
                                          height: 46,
                                          onPress: () {},
                                          color: AppColor.skyBlueButton),
                                      selectedProductProvider.selectedProducts
                                              .contains(
                                                  searchProduct.productModel)
                                          ? SqureIconButton(
                                              icon: const Icon(
                                                Icons.close,
                                                color: AppColor.white,
                                                size: 20,
                                              ),
                                              color: AppColor.brown,
                                              onPress: () {
                                                // selectedProductProvider.removeProduct(product)
                                              })
                                          : Container()
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
