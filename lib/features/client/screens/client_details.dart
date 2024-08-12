import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/features/client/controller/client_provider_controller.dart';
import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/features/orders/model/order_model.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/widgets/common/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/common/k_text_form_field.dart';
import 'package:girdhari/widgets/common/rectangular_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClientDetails extends StatefulWidget {
  final ClientModel client;
  const ClientDetails({super.key, required this.client});

  @override
  State<ClientDetails> createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController paymentAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _dateController.dispose();
    tabController.dispose();
    paymentAmountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.client.clientName,
          style: KTextStyle.K_20,
        ),
        centerTitle: true,
      ),
      body: Consumer<ClientProviderController>(
          builder: (context, clientProviderController, _) {
        return DefaultTabController(
          length: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width / 3,
                      child: FlexiableRectangularButton(
                        title:
                            clientProviderController.totalBillAmount.toString(),
                        width: 150,
                        textColor: Colors.black,
                        height: 30,
                        color: AppColor.thinPurple,
                        onPress: () {},
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 3,
                      child: ConfermRectangularButton(
                        title: clientProviderController.totalPaymentAmount
                            .toString(),
                        textColor: Colors.black,
                        width: 150,
                        height: 30,
                        color: AppColor.skyBlueButton,
                        onPress: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                TabBar(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: -60, vertical: -10),
                  dividerColor: AppColor.grey.withOpacity(0),
                  unselectedLabelStyle: KTextStyle.K_12,
                  indicator: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: AppColor.yellowButton,
                  ),
                  controller: tabController,
                  tabs: const [
                    Text("Bills"),
                    Text("Payments"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Consumer<ClientProviderController>(
                      builder: (context, clientProviderController, _) {
                    return TabBarView(
                      controller: tabController,
                      children: [
                        Column(
                          children: [
                            StreamBuilder<List<OrderModel>>(
                                stream:
                                    clientProviderController.fetchClientOrder(),
                                builder: (context, snapshot) {
                                  return snapshot.data == null
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Expanded(
                                          child: ListView.builder(
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (context, index) {
                                                OrderModel orderDetails =
                                                    snapshot.data![index];
                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      border: Border.all(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  height: 70,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            orderDetails.id,
                                                            style:
                                                                KTextStyle.K_12,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          RectangularButton(
                                                              title: DateFormat(
                                                                      'dd/MM/yy')
                                                                  .format(
                                                                      orderDetails
                                                                          .date),
                                                              color: AppColor
                                                                  .yellow)
                                                        ],
                                                      ),
                                                      FlexiableRectangularButton(
                                                          title: orderDetails
                                                              .totalAmount
                                                              .toString(),
                                                          width: 100,
                                                          height: 35,
                                                          color: AppColor
                                                              .skyBlueButton,
                                                          onPress: () {})
                                                    ],
                                                  ),
                                                );
                                              }),
                                        );
                                }),
                          ],
                        ),

                        ////////////////////////// SECOND TAB  ////////////////////////
                        Column(
                          children: [
                            StreamBuilder<List<ClientPaymentModel>>(
                                stream: clientProviderController
                                    .fetchPaymentDetails(),
                                builder: (context, snapshot) {
                                  return snapshot.data == null
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : Expanded(
                                          child: ListView.builder(
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (context, index) {
                                                ClientPaymentModel paymentDate =
                                                    snapshot.data![index];
                                                return Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      border: Border.all(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  height: 60,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      RectangularButton(
                                                          title: DateFormat(
                                                                  'dd/MM/yy')
                                                              .format(DateTime
                                                                  .parse(paymentDate
                                                                      .paymentDate))
                                                              .toString(),
                                                          color:
                                                              AppColor.yellow),
                                                      FlexiableRectangularButton(
                                                          title: paymentDate
                                                              .paymentAmount
                                                              .toString(),
                                                          width: 100,
                                                          height: 35,
                                                          color: AppColor
                                                              .skyBlueButton,
                                                          onPress: () {})
                                                    ],
                                                  ),
                                                );
                                              }),
                                        );
                                }),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.brown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Consumer<ClientProviderController>(
                  builder: (context, clientProvideController, _) {
                return SizedBox(
                  height: 350,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        KTextFormField(
                            controller: paymentAmountController,
                            validator: (value) {
                              if (paymentAmountController.text.isEmpty) {
                                return "Enter payment Amount";
                              }
                              return null;
                            },
                            hintText: "payment amount"),
                        TextFormField(
                          controller: _dateController,
                          validator: (value) {
                            if (_dateController.text.isEmpty) {
                              return "select date";
                            }
                            return null;
                          },
                          readOnly: true,
                          onTap: () => clientProvideController.selectDate(
                              context, _dateController),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(25, 0, 10, 0),
                            labelText: 'Select Date',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FlexiableRectangularButton(
                          title: "ADD PAYMENT",
                          width: 120,
                          height: 44,
                          color: AppColor.brown,
                          loading: clientProvideController.paymentLoading,
                          onPress: () {
                            clientProvideController.setPaymentLoading(true);
                            ClientPaymentModel paymentModel =
                                ClientPaymentModel(
                                    paymentAmount: double.parse(
                                        paymentAmountController.text),
                                    paymentDate:
                                        DateTime.now().toIso8601String());
                            clientProvideController.addPayment(
                                paymentModel, widget.client);
                            paymentAmountController.text = '';
                            _dateController.text = '';
                          },
                        )
                      ],
                    ),
                  ),
                );
              });
            },
          );
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
