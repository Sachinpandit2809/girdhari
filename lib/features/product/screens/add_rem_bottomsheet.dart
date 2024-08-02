// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:girdhari/features/product/controller/edit_product_controller.dart';
// import 'package:girdhari/features/product/model/add_product_model.dart';
// import 'package:girdhari/resource/app_color.dart';
// import 'package:girdhari/resource/k_text_style.dart';
// import 'package:girdhari/utils/utils.dart';
// import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
// import 'package:girdhari/widgets/k_text_form_field.dart';

// class AddRemBottomsheet extends StatefulWidget {
//   const AddRemBottomsheet({super.key});

//   @override
//   State<AddRemBottomsheet> createState() => _AddRemBottomsheetState();
// }

// class _AddRemBottomsheetState extends State<AddRemBottomsheet> with SingleTickerProviderStateMixin {

// TextEditingController searchProductController = TextEditingController();
//   late TabController tabController;
//   // late TabController secondTabController;

//   TextEditingController addQuantiyController = TextEditingController();

//   final EditProductController _editProductController = EditProductController();

//   TextEditingController removeQuantiyController = TextEditingController();
//   DateTime selectedDate = DateTime.now();
//   final productsCollectionRef =
//       FirebaseFirestore.instance.collection('productStock');
//   final fireStore =
//       FirebaseFirestore.instance.collection('productStock').snapshots();
//   bool loading = false;
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 2, vsync: this);
//     // secondTabController = TabController(length: 4, vsync: this);
//   }

//   @override
//   void dispose() {
//     searchProductController.dispose();
//     tabController.dispose();
//     addQuantiyController.dispose();
//     removeQuantiyController.dispose();

//     super.dispose();
//   }

//   String? selectedCategory;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     margin: const EdgeInsets.symmetric(vertical: 10),
//                     decoration: BoxDecoration(
//                       color: AppColor.grey,
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                     child: TabBar(
//                       controller: tabController,
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       indicatorPadding: const EdgeInsets.symmetric(
//                           horizontal: -60, vertical: -10),
//                       dividerColor: AppColor.grey.withOpacity(0),
//                       unselectedLabelStyle: KTextStyle.K_10,
//                       indicator: const BoxDecoration(
//                         shape: BoxShape.rectangle,
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         color: AppColor.yellowButton,
//                       ),
//                       tabs: const <Widget>[
//                         Text(
//                           "Add",
//                           style: KTextStyle.K_14,
//                         ),
//                         Text(
//                           "Remove",
//                           style: KTextStyle.K_14,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 300, // Adjust the height as needed
//                     child: TabBarView(controller: tabController, children: [
//                       ////// First tab

//                       Column(
//                         children: [
//                           const SizedBox(
//                             height: 30,
//                           ),
//                           KTextFormField(
//                               controller: addQuantiyController,
//                               keyBoard: TextInputType.number,
//                               hintText: "Enter Quantity"),
//                           const SizedBox(
//                             height: 40,
//                           ),
//                           FlexiableRectangularButton(
//                             title: "SUBMIT",
//                             width: 120,
//                             height: 44,
//                             color: AppColor.brown,
//                             onPress: () async {
//                               try {
//                                 int addQuantity =
//                                     int.tryParse(addQuantiyController.text) ??
//                                         0;
//                                 int newAvailableQuantity =
//                                     (data.availableQuantity ?? 0) + addQuantity;

//                                 // Create a new ProductModel instance with the updated quantity
//                                 ProductModel updatedProduct = ProductModel(
//                                   id: data.id,
//                                   time: data.time,
//                                   availableQuantity: newAvailableQuantity,
//                                   productName: data.productName,
//                                   skuCode: data.skuCode,
//                                   weight: data.weight,
//                                   packaging: data.packaging,
//                                   cost: data.cost,
//                                   wholesalePrice: data.wholesalePrice,
//                                   mrp: data.mrp,
//                                 );

//                                 // Call editProduct method to update the product in the database
//                                 EditProductController()
//                                     .editProduct(updatedProduct);
//                                 Get.back();
//                               } catch (e) {
//                                 Utils().toastErrorMessage(e.toString());
//                               }
//                             },
//                           ),
//                         ],
//                       ),

//                       ////// First tab

//                       Column(
//                         children: [
//                           const SizedBox(
//                             height: 30,
//                           ),
//                           KTextFormField(
//                               controller: removeQuantiyController,
//                               keyBoard: TextInputType.number,
//                               hintText: "Enter Quantity"),
//                           const SizedBox(
//                             height: 30,
//                           ),
//                           //..................................................

//                           ToggleButtons(
//                             isSelected: [
//                               selectedCategory == 'Wholesale',
//                               selectedCategory == 'Retails',
//                               selectedCategory == 'Gift',
//                               selectedCategory == 'Puja Kit',
//                             ],
//                             onPressed: (int index) {
//                               setState(() {
//                                 switch (index) {
//                                   case 0:
//                                     selectedCategory = 'Wholesale';
//                                     break;
//                                   case 1:
//                                     selectedCategory = 'Retails';
//                                     break;
//                                   case 2:
//                                     selectedCategory = 'Gift';
//                                     break;
//                                   case 3:
//                                     selectedCategory = 'Puja Kit';
//                                     break;
//                                 }
//                               });
//                             },
//                             children: const [
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                                 child: Text('Wholesale'),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                                 child: Text('Retails'),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                                 child: Text('Gift'),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                                 child: Text('Puja Kit'),
//                               ),
//                             ],
//                           ),

//                           //.....................................

//                           const SizedBox(
//                             height: 40,
//                           ),
//                           FlexiableRectangularButton(
//                             ////// remove button
//                             title: "SUBMIT",
//                             width: 120,
//                             height: 44,
//                             color: AppColor.brown,
//                             onPress: () async {
//                               try {
//                                 int removeQuantity = int.tryParse(
//                                         removeQuantiyController.text) ??
//                                     0;
//                                 int newAvailableQuantity =
//                                     (data.availableQuantity ?? 0) -
//                                         removeQuantity;

//                                 // Create a new ProductModel instance with the updated quantity
//                                 ProductModel updatedProduct = ProductModel(
//                                   id: data.id,
//                                   time: data.time,
//                                   availableQuantity: newAvailableQuantity,
//                                   productName: data.productName,
//                                   skuCode: data.skuCode,
//                                   weight: data.weight,
//                                   packaging: data.packaging,
//                                   cost: data.cost,
//                                   wholesalePrice: data.wholesalePrice,
//                                   mrp: data.mrp,
//                                 );

//                                 // Call editProduct method to update the product in the database
//                                 EditProductController()
//                                     .editProduct(updatedProduct);
//                                 Get.back();
//                               } catch (e) {
//                                 Utils().toastErrorMessage(e.toString());
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ]),
//                   ),
//                 ]),
//           );
//         });
//   }


//   }


