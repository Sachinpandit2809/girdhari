import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/k_text_form_field.dart';
import 'package:girdhari/widgets/rectangular_button.dart';
import 'package:girdhari/widgets/small_square_button.dart';
import 'package:girdhari/widgets/squre_icon_button.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/features/orders/screens/orders_screen.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  // ignore: non_constant_identifier_names
  TextEditingController SearchClientController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController SearchProductController = TextEditingController();

  @override
  void dispose() {
    SearchClientController.dispose();
    SearchProductController.dispose();

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
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Review",
                style: KTextStyle.K_13.copyWith(color: AppColor.brown),
              )),
          RectangularButton(
            title: "Conferm",
            color: AppColor.brown,
            textColor: AppColor.white,
            onPress: () {
              
              Get.to(const OrdersScreen());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              KTextFormField(
                  controller: SearchClientController,
                  hintText: "Search Client"),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                margin: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    boxShadow: const [
                      BoxShadow(
                        color:
                            Colors.black45, // Adjust opacity for a blush effect
                        offset: Offset(0, 5), // Move the shadow downwards
                        blurRadius: 10, // Adjust blur radius as needed
                        spreadRadius: 2, // Adjust spread radius as needed
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
                        onPress: () {})
                  ],
                ),
              ),
              KTextFormField(
                  controller: SearchProductController,
                  hintText: "Search Product"),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                margin: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            "Roli / KumKum Powder",
                            style: KTextStyle.K_16,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RectangularButton(
                                title: "Bottle", color: AppColor.skyBlueButton),
                            RectangularButton(
                                title: "25 GM", color: AppColor.yellowButton),
                            SmallSquareButton(
                                title: "10", color: AppColor.yellow),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        FlexiableRectangularButton(
                            textColor: Colors.black,
                            title: "12",
                            width: 51,
                            height: 46,
                            onPress: () {},
                            color: AppColor.skyBlueButton),
                        SqureIconButton(
                            icon: const Icon(
                              Icons.close,
                              color: AppColor.white,
                              size: 20,
                            ),
                            color: AppColor.brown,
                            onPress: () {})
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
