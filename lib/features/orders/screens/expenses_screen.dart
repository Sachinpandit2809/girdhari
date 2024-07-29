import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/k_text_form_field.dart';
import 'package:girdhari/widgets/rectangular_button.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/features/orders/screens/orders_details_screen.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController; // Add TabController instance

  TextEditingController searchExpensesController = TextEditingController();
  TextEditingController venderDetailsController = TextEditingController();
  TextEditingController expenseTitleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    searchExpensesController.dispose();
    venderDetailsController.dispose();
    expenseTitleController.dispose();
    amountController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Expenses",
            style: KTextStyle.K_20,
          ),
          actions: [
            FlexiableRectangularButton(
                title: "\u{20B9} 5,00,00",
                textColor: Colors.black,
                width: 130,
                height: 30,
                color: AppColor.skyBlueButton,
                onPress: () {})
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              KTextFormField(
                  controller: searchExpensesController,
                  hintText: "Search Expenses"),
              Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            bottomSheet();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 4),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary, // Adjust opacity for a blush effect
                                    offset: const Offset(
                                        0, 0), // Move the shadow downwards
                                    blurRadius:
                                        5, // Adjust blur radius as needed
                                    spreadRadius:
                                        0, // Adjust spread radius as needed
                                    blurStyle: BlurStyle.outer,
                                  )
                                ]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //details
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sticker Purchase",
                                      style: KTextStyle.K_14,
                                    ),
                                    Text(
                                      "Kailash saw computers",
                                      style: KTextStyle.K_10,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        RectangularButton(
                                            title: "PACKAGING",
                                            color: AppColor.skyBlueButton),
                                        RectangularButton(
                                            title: "27 jul 24",
                                            color: AppColor.yellow),
                                      ],
                                    )
                                  ],
                                ),
                                //figure
                                RectangularButton(
                                    onPress: () {},
                                    title: "\u{20B9} 2,000",
                                    color: AppColor.skyBlueButton)
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.brown,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          onPressed: () {
          
            Get.to(const OrdersDetailsScreen());
          },
          child: const Icon(
            Icons.add,
            color: AppColor.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  void bottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 510,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    KTextFormField(
                        controller: venderDetailsController,
                        hintText: "Enter Vender Details"),
                    KTextFormField(
                        controller: expenseTitleController,
                        hintText: "Enter Expense Title"),
                    KTextFormField(
                        controller: amountController, hintText: "Enter Amount"),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      // Set background color of the TabBar
                      child: TabBar(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        indicatorPadding: const EdgeInsets.symmetric(
                            horizontal: -15, vertical: -10),
                        dividerColor: AppColor.grey.withOpacity(0),
                        // indicatorWeight: 4.0,
                        unselectedLabelStyle: KTextStyle.K_10,
                        indicator: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        controller: tabController,
                        tabs: const <Widget>[
                          Text(
                            "Raw Material",
                            style: KTextStyle.K_14,
                          ),
                          Text(
                            "Packaging",
                            style: KTextStyle.K_14,
                          ),
                          Text(
                            "Others",
                            style: KTextStyle.K_14,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
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
                      title: "SUBMIT",
                      width: 120,
                      height: 44,
                      color: AppColor.brown,
                      onPress: () {
                        Get.back();
                      },
                    )
                  ]),
            ),
          ),
        );
      },
    );
  }
}
