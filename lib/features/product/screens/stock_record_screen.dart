import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';
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

  String? selectedCategory;

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
                              onLongPress: () {
                                showDateSheet();
                              },
                              onTap: () {
                                // addBottomSheet();
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
                                        title: "12",
                                        width: 51,
                                        height: 46,
                                        onPress: () {},
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
                              onLongPress: () {
                                showDateSheet();
                              },
                              onTap: () {
                                addBottomSheet();
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
                                          padding: EdgeInsets.symmetric(
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
                                        title: "12",
                                        width: 51,
                                        height: 46,
                                        onPress: () {},
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

  void addBottomSheet() {
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
                              hintText: "Enter Quantity"),
                          const SizedBox(
                            height: 40,
                          ),
                          FlexiableRectangularButton(
                            title: "SUBMIT",
                            width: 120,
                            height: 44,
                            color: AppColor.brown,
                            onPress: () {
                              Get.back();
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
                              hintText: "Enter Quantity"),
                          const SizedBox(
                            height: 30,
                          ),
                          //..................................................

                          ToggleButtons(
                            isSelected: [
                              selectedCategory == 'Wholesale',
                              selectedCategory == 'Retails',
                              selectedCategory == 'Gift',
                              selectedCategory == 'Puja Kit',
                            ],
                            onPressed: (int index) {
                              setState(() {
                                switch (index) {
                                  case 0:
                                    selectedCategory = 'Wholesale';
                                    break;
                                  case 1:
                                    selectedCategory = 'Retails';
                                    break;
                                  case 2:
                                    selectedCategory = 'Gift';
                                    break;
                                  case 3:
                                    selectedCategory = 'Puja Kit';
                                    break;
                                }
                              });
                            },
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text('Wholesale'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text('Retails'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text('Gift'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text('Puja Kit'),
                              ),
                            ],
                          ),

                          //.....................................

                          const SizedBox(
                            height: 40,
                          ),
                          FlexiableRectangularButton(
                            title: "SUBMIT",
                            width: 120,
                            height: 44,
                            color: AppColor.brown,
                            onPress: () {
                              Get.back();
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

  showDateSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            children: [
              const SizedBox(
                height: 50,
                child: Center(child: Icon(Icons.drag_handle_sharp)),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return StockShowDateSheet(
                      date: "28 jul 24", buttonTitle: "buttom", count: "24");
                },
              ))
            ],
          );
        });
  }
}
