import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/k_text_form_field.dart';
import 'package:girdhari/widgets/rectangular_button.dart';
// import 'package:girdhari/re_usable_widgets/squre_icon_button.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/features/expenses/screen/expenses_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // ignore: non_constant_identifier_names
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
                controller: SearchClientController, hintText: "Search Client"),
            Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
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
                                    0, 1), // Move the shadow downwards
                                blurRadius: 6, // Adjust blur radius as needed
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
                                  "Shree Shyam Store",
                                  style: KTextStyle.K_14,
                                ),
                                Text(
                                  "Howrah",
                                  style: KTextStyle.K_10,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                RectangularButton(
                                    title: "27 jul 24", color: AppColor.yellow)
                              ],
                            ),
                            //figure
                            RectangularButton(
                                onPress: () {},
                                title: index % 2 != 0 ? "PENDING" : "COMPLETE",
                                color: index % 2 != 0
                                    ? AppColor.yellowButton
                                    : AppColor.green)
                          ],
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
         
          Get.to(const ExpensesScreen());
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
