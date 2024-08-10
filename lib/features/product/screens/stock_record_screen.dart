import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';

import 'package:girdhari/features/product/controller/product_controller.dart';
import 'package:girdhari/features/product/controller/product_date_controller.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/features/product/model/date_model.dart';
import 'package:girdhari/features/product/provider/product_controller_provider.dart';
import 'package:girdhari/features/product/provider/remove_stock_provider.dart';
import 'package:girdhari/features/product/screens/edit_product_screen.dart';
import 'package:girdhari/utils/utils.dart';

import 'package:girdhari/widgets/common/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/common/k_text_form_field.dart';
import 'package:girdhari/widgets/common/rectangular_button.dart';
import 'package:girdhari/widgets/common/search_k_textformfield.dart';
import 'package:girdhari/widgets/common/small_square_button.dart';
import 'package:girdhari/widgets/common/stock_show_date_sheet.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/features/product/screens/add_product_screen.dart';
import 'package:intl/intl.dart';
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
  final fireStore = FirebaseFirestore.instance
      .collection('productStock')
      .where("is_deleted", isEqualTo: false)
      .snapshots();

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
                if (snapshot.data!.docs.isEmpty) {
                  Utils().toastErrorMessage("No Data Found");
                }
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ProductModel product = ProductModel.fromJson(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>);
                          if (searchProductController.text.isEmpty) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 3),
                              margin: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: product.availableQuantity! > 0
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(8)),
                              child: InkWell(
                                onLongPress: () {
                                  debugPrint("....................triggred");
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Consumer<
                                                ProductControllerProvider>(
                                            builder: (context,
                                                productControllerProvider, _) {
                                          return AlertDialog(
                                            content: SizedBox(
                                              height: 250,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  FlexiableRectangularButton(
                                                      title: "edit Product",
                                                      width: 140,
                                                      height: 40,
                                                      loading:
                                                          productControllerProvider
                                                              .editproductLoading,
                                                      color: AppColor.green,
                                                      onPress: () {
                                                        Get.to(() =>
                                                            EditProductScreen(
                                                                product:
                                                                    product));
                                                      }),
                                                  FlexiableRectangularButton(
                                                      title: "flag Zero",
                                                      width: 140,
                                                      height: 40,
                                                      loading:
                                                          productControllerProvider
                                                              .flagZeroLoading,
                                                      color: AppColor.yellow,
                                                      onPress: () {
                                                        productControllerProvider
                                                            .setflagZeroLoading(
                                                                true);
                                                        DateModel flagZeroDate =
                                                            DateModel(
                                                                id: product.id,
                                                                date:
                                                                    "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                                                                sellTag:
                                                                    "Flag Zero",
                                                                quantity: product
                                                                        .availableQuantity ??
                                                                    0);
                                                        ProductModel
                                                            setZeroFlag =
                                                            ProductModel(
                                                                id: product.id,
                                                                time: product
                                                                    .time,
                                                                availableQuantity:
                                                                    0,
                                                                productName: product
                                                                    .productName,
                                                                skuCode: product
                                                                    .skuCode,
                                                                weight: product
                                                                    .weight,
                                                                packaging: product
                                                                    .packaging,
                                                                cost: product
                                                                    .cost,
                                                                wholesalePrice:
                                                                    product
                                                                        .wholesalePrice,
                                                                mrp: product
                                                                    .mrp);
                                                        productControllerProvider
                                                            .flagZero(
                                                                setZeroFlag,
                                                                flagZeroDate);
                                                      }),
                                                  FlexiableRectangularButton(
                                                      title: "delete",
                                                      width: 140,
                                                      height: 40,
                                                      loading:
                                                          productControllerProvider
                                                              .deleteProductLoading,
                                                      color: AppColor.brownRed,
                                                      onPress: () {
                                                        productControllerProvider
                                                            .setDeleteProductLoading(
                                                                true);
                                                        productControllerProvider
                                                            .deleteProduct(
                                                                product.id);
                                                      })
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                      });
                                },
                                onTap: () {
                                  showDateSheet(product);
                                },
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
                                            product.productName,
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
                                                title: product.packaging,
                                                color: AppColor.skyBlue),
                                            RectangularButton(
                                                title: product.weight,
                                                color: AppColor.yellowButton),
                                            SmallSquareButton(
                                                title: product.cost.toString(),
                                                color: AppColor.skyBlue),
                                            SmallSquareButton(
                                                title: product.wholesalePrice
                                                    .toString(),
                                                color: AppColor.yellow),
                                            SmallSquareButton(
                                                title: product.mrp.toString(),
                                                color: AppColor.brownRed),
                                          ],
                                        )
                                      ],
                                    ),
                                    FlexiableRectangularButton(
                                        textColor: Colors.black,
                                        title: product.availableQuantity
                                            .toString(),
                                        width: 51,
                                        height: 46,
                                        onPress: () {
                                          addBottomSheet(product);
                                        },
                                        color: AppColor.skyBlue)
                                  ],
                                ),
                              ),
                            );
                          }
                          if (product.productName
                              .toString()
                              .toLowerCase()
                              .contains(
                                  searchProductController.text.toLowerCase())) {
                            return InkWell(
                              onTap: () {
                                showDateSheet(product);
                              },
                              onLongPress: () {
                                debugPrint("....................triggred");
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Consumer<
                                              ProductControllerProvider>(
                                          builder: (context,
                                              productControllerProvider, _) {
                                        return AlertDialog(
                                          content: SizedBox(
                                            height: 250,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                FlexiableRectangularButton(
                                                    title: "edit Product",
                                                    width: 140,
                                                    height: 40,
                                                    loading:
                                                        productControllerProvider
                                                            .editproductLoading,
                                                    color: AppColor.green,
                                                    onPress: () {
                                                      Get.to(() =>
                                                          EditProductScreen(
                                                              product:
                                                                  product));
                                                    }),
                                                FlexiableRectangularButton(
                                                    title: "flag Zero",
                                                    width: 140,
                                                    height: 40,
                                                    loading:
                                                        productControllerProvider
                                                            .flagZeroLoading,
                                                    color: AppColor.yellow,
                                                    onPress: () {
                                                      productControllerProvider
                                                          .setflagZeroLoading(
                                                              true);
                                                      DateModel flagZeroDate =
                                                          DateModel(
                                                              id: product.id,
                                                              date:
                                                                  "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                                                              sellTag:
                                                                  "Flag Zero",
                                                              quantity: product
                                                                      .availableQuantity ??
                                                                  0);
                                                      ProductModel setZeroFlag =
                                                          ProductModel(
                                                              id: product.id,
                                                              time:
                                                                  product.time,
                                                              availableQuantity:
                                                                  0,
                                                              productName: product
                                                                  .productName,
                                                              skuCode: product
                                                                  .skuCode,
                                                              weight: product
                                                                  .weight,
                                                              packaging: product
                                                                  .packaging,
                                                              cost:
                                                                  product.cost,
                                                              wholesalePrice:
                                                                  product
                                                                      .wholesalePrice,
                                                              mrp: product.mrp);
                                                      productControllerProvider
                                                          .flagZero(setZeroFlag,
                                                              flagZeroDate);
                                                    }),
                                                FlexiableRectangularButton(
                                                    title: "delete",
                                                    width: 140,
                                                    height: 40,
                                                    loading:
                                                        productControllerProvider
                                                            .deleteProductLoading,
                                                    color: AppColor.brownRed,
                                                    onPress: () {
                                                      productControllerProvider
                                                          .setDeleteProductLoading(
                                                              true);
                                                      productControllerProvider
                                                          .deleteProduct(
                                                              product.id);
                                                    })
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 3),
                                margin: const EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: product.availableQuantity! > 0
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                        : Colors.red.shade100,
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
                                            product.productName,
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
                                                title: product.packaging,
                                                color: AppColor.skyBlue),
                                            RectangularButton(
                                                title: product.weight,
                                                color: AppColor.yellowButton),
                                            SmallSquareButton(
                                                title: product.cost.toString(),
                                                color: AppColor.skyBlue),
                                            SmallSquareButton(
                                                title: product.wholesalePrice
                                                    .toString(),
                                                color: AppColor.yellow),
                                            SmallSquareButton(
                                                title: product.mrp.toString(),
                                                color: AppColor.brownRed),
                                          ],
                                        )
                                      ],
                                    ),
                                    FlexiableRectangularButton(
                                        textColor: Colors.black,
                                        title: product.availableQuantity
                                            .toString(),
                                        width: 51,
                                        height: 46,
                                        onPress: () {
                                          addBottomSheet(product);
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
                              validator: (value) {
                                if (removeQuantiyController.text.isEmpty) {
                                  return "enter  quantity";
                                }
                                return null;
                              },
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
                              validator: (value) {
                                if (removeQuantiyController.text.isEmpty) {
                                  return "enter quantity";
                                }
                                return null;
                              },
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
                                ProductController().editProduct(updatedProduct);
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
              .orderBy("date", descending: true)
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
