import 'package:flutter/material.dart';
import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/features/orders/controller/bill_provider.dart';

import 'package:girdhari/features/product/model/add_product_model.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/widgets/common/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/common/search_k_textformfield.dart';
import 'package:girdhari/widgets/new_billing_screen/bill_card.dart';
import 'package:girdhari/widgets/new_billing_screen/product_card.dart';
import 'package:provider/provider.dart';

import '../../../resource/app_color.dart';

class NewBillingScreen extends StatefulWidget {
  const NewBillingScreen({super.key});

  @override
  State<NewBillingScreen> createState() => _NewBillingScreenState();
}

class _NewBillingScreenState extends State<NewBillingScreen> {
  final TextEditingController SearchClientController = TextEditingController();
  TextEditingController SearchProductController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  TextEditingController wholesellPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Billing",
          style: KTextStyle.K_20,
        ),
        actions: [
          TextButton(
            child: Text(
              "Reset",
              style: KTextStyle.K_13.copyWith(color: AppColor.brown),
            ),
            onPressed: () {
              final billProvider =
                  Provider.of<BillProvider>(context, listen: false);
              billProvider.emptyProductList();
              billProvider.removeClient();
            },
          ),
          Consumer<BillProvider>(builder: (context, billProvider, _) {
            return ConfermRectangularButton(
                title: "conferm",
                width: 90,
                height: 40,
                color: AppColor.brown,
                loading: billProvider.isConfermLoading,
                onPress: () {
                  billProvider.setConfermLoading(true);
                  billProvider.createOrder();
                });
          })
        ],
      ),
      body: Consumer<BillProvider>(builder: (context, billProvider, _) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Builder(builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //////////////////////////////// search client ////////////////////////////////////
                  FlexiableRectangularButton(
                      title: "search client",
                      width: 200,
                      height: 40,
                      color: AppColor.brown,
                      onPress: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return Consumer<BillProvider>(
                                  builder: (context, newBillProvider, _) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.75,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        left: 20,
                                        right: 20,
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Column(
                                      children: [
                                        SearchKTextformfield(
                                          onChange: (p0) {
                                            setState(() {});
                                          },
                                          controller: SearchClientController,
                                          hintText: "Search Client",
                                        ),
                                        StreamBuilder<List<ClientModel>>(
                                            stream:
                                                newBillProvider.fetchClient(),
                                            builder: (context, snapshot) {
                                              return snapshot.data == null
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator())
                                                  : Expanded(
                                                      child: ListView.builder(
                                                          itemCount: snapshot
                                                              .data!.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            ClientModel client =
                                                                snapshot.data![
                                                                    index];

                                                            if (SearchClientController
                                                                .text.isEmpty) {
                                                              return BillCard(
                                                                  SearchClientController:
                                                                      SearchClientController,
                                                                  newBillProvider:
                                                                      newBillProvider,
                                                                  client:
                                                                      client);
                                                            }
                                                            if (client
                                                                .clientName
                                                                .toLowerCase()
                                                                .contains(
                                                                    SearchClientController
                                                                        .text
                                                                        .toLowerCase())) {
                                                              return BillCard(
                                                                  SearchClientController:
                                                                      SearchClientController,
                                                                  newBillProvider:
                                                                      newBillProvider,
                                                                  client:
                                                                      client);
                                                            }
                                                            return const SizedBox();
                                                          }),
                                                    );
                                            }),
                                      ],
                                    ),
                                  ),
                                );
                              });
                            });
                      }),
                  ////////////////////////////////// SEARCH PRODUCT ////////////////////////////////
                  const SizedBox(
                    height: 20,
                  ),
                  FlexiableRectangularButton(
                      title: "search product",
                      width: 200,
                      height: 40,
                      color: AppColor.brown,
                      onPress: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return Consumer<BillProvider>(
                                  builder: (context, productBillProvider, _) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.75,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        left: 20,
                                        right: 20,
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Builder(builder: (context) {
                                      return Column(
                                        children: [
                                          SearchKTextformfield(
                                            controller: SearchProductController,
                                            hintText: "Search Product",
                                            onChange: (p0) {
                                              setState(() {});
                                            },
                                          ),
                                          StreamBuilder<List<ProductModel>>(
                                              stream:
                                                  billProvider.fetchProducts(),
                                              builder: (context, snapshot) {
                                                return snapshot.data == null
                                                    ? const CircularProgressIndicator()
                                                    : Expanded(
                                                        child: ListView.builder(
                                                            itemCount: snapshot
                                                                .data!.length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              ProductModel
                                                                  product =
                                                                  snapshot.data![
                                                                      index];

                                                              if (SearchProductController
                                                                  .text
                                                                  .isEmpty) {
                                                                return ProductCard(
                                                                    product:
                                                                        product,
                                                                    qtyController:
                                                                        qtyController,
                                                                    wholesellPriceController:
                                                                        wholesellPriceController);
                                                              }
                                                              if (product
                                                                  .productName
                                                                  .toLowerCase()
                                                                  .contains(
                                                                      SearchProductController
                                                                          .text
                                                                          .toLowerCase())) {
                                                                return ProductCard(
                                                                    product:
                                                                        product,
                                                                    qtyController:
                                                                        qtyController,
                                                                    wholesellPriceController:
                                                                        wholesellPriceController);
                                                              }

                                                              return const SizedBox();
                                                            }),
                                                      );
                                              })
                                        ],
                                      );
                                    }),
                                  ),
                                );
                              });
                            });
                      }),
                ],
              );
            }),
          ),
        );
      }),
    );
  }
}
