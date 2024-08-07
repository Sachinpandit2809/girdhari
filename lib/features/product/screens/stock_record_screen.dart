import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:girdhari/features/product/controller/product_controller.dart';
import 'package:girdhari/features/product/controller/product_date_controller.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/features/product/model/date_model.dart';
import 'package:girdhari/features/product/provider/remove_stock_provider.dart';
import 'package:girdhari/features/product/screens/edit_product_screen.dart';
import 'package:girdhari/utils/utils.dart';

import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/k_text_form_field.dart';
import 'package:girdhari/widgets/rectangular_button.dart';
import 'package:girdhari/widgets/search_k_textformfield.dart';
import 'package:girdhari/widgets/small_square_button.dart';
import 'package:girdhari/widgets/stock_show_date_sheet.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/features/product/screens/add_product_screen.dart';
import 'package:provider/provider.dart';

class StockRecordScreen extends StatefulWidget {
  const StockRecordScreen({super.key});

  @override
  State<StockRecordScreen> createState() => _StockRecordScreenState();
}

class _StockRecordScreenState extends State<StockRecordScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController searchProductController = TextEditingController();
  late TabController tabController;
  // late TabController secondTabController;

  TextEditingController addQuantiyController = TextEditingController();

  TextEditingController removeQuantiyController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final productsCollectionRef =
      FirebaseFirestore.instance.collection('productStock');
  final fireStore =
      FirebaseFirestore.instance.collection('productStock').snapshots();

  final dateCollection =
      FirebaseFirestore.instance.collection('productStockDate');
  final dateFireStore =
      FirebaseFirestore.instance.collection('productStockDate').snapshots();

  bool loading = false;
  bool toggleLoading = false;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    // secondTabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    searchProductController.dispose();
    tabController.dispose();
    addQuantiyController.dispose();
    removeQuantiyController.dispose();

    super.dispose();
  }

  // String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Stock Report",
          style: KTextStyle.K_20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: SearchKTextformfield(
                  controller: searchProductController,
                  hintText: "Search Product",
                  onChange: (String value) {
                    setState(() {});
                  },
                )),
                IconButton(
                  icon: Image.asset('assets/images/png/icon_filter.png'),
                  onPressed: () {
                    //function
                  },
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  Utils().toastErrorMessage("error during communication");
                }
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // ProductModel myData = ProductModel.fromJson(snapshot.data!.docs[index].data());
                          ProductModel myData = ProductModel.fromJson(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>);
                          //dynamic myData = snapshot.data!.docs[index];
                          if (searchProductController.text.isEmpty) {
                            return InkWell(
                              onTap: () {
                                showDateSheet(myData);
                              },
                              onLongPress: () {
                                debugPrint("object triggred");

                                Get.to(EditProductScreen(data: myData));
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                            // "Roli / KumKum Powder",
                                            // snapshot.data!.docs[index][""],
                                            myData.productName,
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
                                                title: myData.packaging,
                                                color: AppColor.skyBlue),
                                            RectangularButton(
                                                title: myData.weight,
                                                color: AppColor.yellowButton),
                                            SmallSquareButton(
                                                title: myData.cost.toString(),
                                                color: AppColor.skyBlue),
                                            SmallSquareButton(
                                                title: myData.wholesalePrice
                                                    .toString(),
                                                color: AppColor.yellow),
                                            SmallSquareButton(
                                                title: myData.mrp.toString(),
                                                color: AppColor.brownRed),
                                          ],
                                        )
                                      ],
                                    ),
                                    FlexiableRectangularButton(
                                        textColor: Colors.black,
                                        title:
                                            myData.availableQuantity.toString(),
                                        width: 51,
                                        height: 46,
                                        onPress: () {
                                          addBottomSheet(myData);
                                        },
                                        color: AppColor.skyBlue)
                                  ],
                                ),
                              ),
                            );
                          }
                          if (myData.productName
                              .toString()
                              .toLowerCase()
                              .contains(
                                  searchProductController.text.toLowerCase())) {
                            return InkWell(
                              onTap: () {
                                showDateSheet(myData);
                              },
                              onLongPress: () {
                                Get.to(EditProductScreen(data: myData));
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                            // "Roli / KumKum Powder",
                                            // snapshot.data!.docs[index][""],
                                            myData.productName,
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
                                                title: myData.packaging,
                                                color: AppColor.skyBlue),
                                            RectangularButton(
                                                title: myData.weight,
                                                color: AppColor.yellowButton),
                                            SmallSquareButton(
                                                title: myData.cost.toString(),
                                                color: AppColor.skyBlue),
                                            SmallSquareButton(
                                                title: myData.wholesalePrice
                                                    .toString(),
                                                color: AppColor.yellow),
                                            SmallSquareButton(
                                                title: myData.mrp.toString(),
                                                color: AppColor.brownRed),
                                          ],
                                        )
                                      ],
                                    ),
                                    FlexiableRectangularButton(
                                        textColor: Colors.black,
                                        title:
                                            myData.availableQuantity.toString(),
                                        width: 51,
                                        height: 46,
                                        onPress: () {
                                          addBottomSheet(myData);
                                        },
                                        color: AppColor.skyBlue)
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
          Get.to(const AddProductScreen());
        },
        child: const Icon(
          Icons.add,
          color: AppColor.white,
          size: 30,
        ),
      ),
    );
  }

  void addBottomSheet(ProductModel data) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColor.grey,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TabBar(
                      controller: tabController,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      indicatorPadding: const EdgeInsets.symmetric(
                          horizontal: -60, vertical: -10),
                      dividerColor: AppColor.grey.withOpacity(0),
                      unselectedLabelStyle: KTextStyle.K_10,
                      indicator: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: AppColor.yellowButton,
                      ),
                      tabs: const <Widget>[
                        Text(
                          "Add",
                          style: KTextStyle.K_14,
                        ),
                        Text(
                          "Remove",
                          style: KTextStyle.K_14,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 300, // Adjust the height as needed
                    child: TabBarView(controller: tabController, children: [
                      ////// First tab

                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          KTextFormField(
                              controller: addQuantiyController,
                              keyBoard: TextInputType.number,
                              hintText: "Enter Quantity"),
                          const SizedBox(
                            height: 40,
                          ),
                          FlexiableRectangularButton(
                            title: "SUBMIT",
                            width: 120,
                            height: 44,
                            color: AppColor.brown,
                            onPress: () async {
                              try {
                                int addQuantity =
                                    int.tryParse(addQuantiyController.text) ??
                                        0;
                                int newAvailableQuantity =
                                    (data.availableQuantity ?? 0) + addQuantity;
                                String id = data.id;
                                String date =
                                    "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
                                String sellTag = "created";
                                int quantity = addQuantity;
                                // Create a new DateModel instance with the updated
                                DateModel productDate = DateModel(
                                    id: id,
                                    date: date,
                                    sellTag: sellTag,
                                    quantity: quantity);

                                // Create a new ProductModel instance with the updated quantity
                                ProductModel updatedProduct = ProductModel(
                                  id: data.id,
                                  time: data.time,
                                  availableQuantity: newAvailableQuantity,
                                  productName: data.productName,
                                  skuCode: data.skuCode,
                                  weight: data.weight,
                                  packaging: data.packaging,
                                  cost: data.cost,
                                  wholesalePrice: data.wholesalePrice,
                                  mrp: data.mrp,
                                );

                                // Call editProduct method to update the product in the database
                                ProductDateController()
                                    .addProductDate(productDate)
                                    .then((onValue) {
                                  debugPrint("################## date added");
                                  
                                }).onError(
                                  (error, stackTrace) {
                                    Utils().toastErrorMessage(
                                        "error in update date");
                                  },
                                );

                                ProductController()
                                    .editProduct(updatedProduct)
                                    .then((onValue) {
                                  Utils().toastSuccessMessage(
                                      "$addQuantity stock updated");
                                }).onError(
                                  (error, stackTrace) {
                                    Utils().toastErrorMessage(
                                        "error in Stock update");
                                  },
                                );
                                Get.back();
                              } catch (e) {
                                Utils().toastErrorMessage(e.toString());
                              }
                            },
                          ),
                        ],
                      ),

                      ////// First tab

                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          KTextFormField(
                              controller: removeQuantiyController,
                              keyBoard: TextInputType.number,
                              hintText: "Enter Quantity"),
                          const SizedBox(
                            height: 30,
                          ),
                          //..................................................
                          Center(
                            child: Consumer<RemoveStockProvider>(
                              builder: (context, categoryProvider, child) {
                                return ToggleButtons(
                                  isSelected: [
                                    categoryProvider.selectedCategory ==
                                        'Wholesale',
                                    categoryProvider.selectedCategory ==
                                        'Retails',
                                    categoryProvider.selectedCategory == 'Gift',
                                    categoryProvider.selectedCategory ==
                                        'Puja Kit',
                                  ],
                                  onPressed: (int index) {
                                    switch (index) {
                                      case 0:
                                        categoryProvider
                                            .setCategory('Wholesale');
                                        break;
                                      case 1:
                                        categoryProvider.setCategory('Retails');
                                        break;
                                      case 2:
                                        categoryProvider.setCategory('Gift');
                                        break;
                                      case 3:
                                        categoryProvider
                                            .setCategory('Puja Kit');
                                        break;
                                    }
                                  },
                                  selectedColor:
                                      Colors.white, // Color of selected text
                                  fillColor: Colors
                                      .blue, // Background color of selected button
                                  color:
                                      Colors.black, // Color of unselected text
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text('Wholesale'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text('Retails'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text('Gift'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text('Puja Kit'),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          //.....................................

                          const SizedBox(
                            height: 40,
                          ),
                          FlexiableRectangularButton(
                            ////// remove button
                            title: "SUBMIT",
                            width: 120,
                            height: 44,
                            color: AppColor.brown,
                            onPress: () async {
                              try {
                                int removeQuantity = int.tryParse(
                                        removeQuantiyController.text) ??
                                    0;

                                if (((data.availableQuantity ?? 0) -
                                        removeQuantity) <
                                    0) {
                                  Utils().toastErrorMessage(
                                      "not sufficient stock, only ${data.availableQuantity}");
                                  return;
                                }

                                int newAvailableQuantity =
                                    (data.availableQuantity ?? 0) -
                                        removeQuantity;
                                //.....................

                                String id = data.id;
                                String date =
                                    "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
                                final rem = Provider.of<RemoveStockProvider>(
                                    context,
                                    listen: false);
                                String sellTag = rem.selectedCategory;
                                int quantity = removeQuantity;
                                // Create a new DateModel instance with the updated
                                DateModel productDate = DateModel(
                                    id: id,
                                    date: date,
                                    sellTag: sellTag,
                                    quantity: quantity);
                                ProductDateController()
                                    .addProductDate(productDate)
                                    .then((onValue) {
                                  debugPrint("################## date added");
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(content: Text("date added")));
                                }).onError(
                                  (error, stackTrace) {
                                    Utils().toastErrorMessage(
                                        "error in update date");
                                  },
                                );
                                ////////////////////////////////////////////////////////

                                //......................
                                // Create a new ProductModel instance with the updated quantity
                                ProductModel updatedProduct = ProductModel(
                                  id: data.id,
                                  time: data.time,
                                  availableQuantity: newAvailableQuantity,
                                  productName: data.productName,
                                  skuCode: data.skuCode,
                                  weight: data.weight,
                                  packaging: data.packaging,
                                  cost: data.cost,
                                  wholesalePrice: data.wholesalePrice,
                                  mrp: data.mrp,
                                );

                                // Call editProduct method to update the product in the database
                                ProductController()
                                    .editProduct(updatedProduct);
                                Get.back();
                              } catch (e) {
                                debugPrint(e.toString());
                                Utils().toastErrorMessage(e.toString());
                              }
                            },
                          ),
                        ],
                      ),
                    ]),
                  ),
                ]),
          );
        });
  }

  //  showDateSheet(String date, String buttonTitle, String count)

  showDateSheet(ProductModel productData) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          final dateCollectionDetails = dateCollection
              .doc(productData.id)
              .collection("stockDateList")
              .snapshots();

          return Column(
            children: [
              const SizedBox(
                height: 50,
                child: Center(child: Icon(Icons.drag_handle_sharp)),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: dateCollectionDetails,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    Utils().toastErrorMessage("error in connection ");
                  }
                  return Expanded(
                      child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      ///////////////////////////////////////////////////////////
                      DateModel date = DateModel.fromJson(
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>);

                      return StockShowDateSheet(
                          date: date.date,
                          buttonTitle: date.sellTag,
                          count: date.quantity.toString());
                    },
                  ));
                },
              )
            ],
          );
        });
  }
}









  // PopupMenuButton(
      
  //     itemBuilder: (context) {
  //       return [
  //         const PopupMenuItem(
  //           child: Text("edit"),
  //         ),
  //         const PopupMenuItem(
  //           child: Text("delete"),
  //         )
  //       ];
  //     },
  //   );