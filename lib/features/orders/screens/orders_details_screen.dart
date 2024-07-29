import 'package:flutter/material.dart';
import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/rectangular_button.dart';
import 'package:girdhari/widgets/small_square_button.dart';
import 'package:girdhari/widgets/squre_icon_button.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';

class OrdersDetailsScreen extends StatefulWidget {
  const OrdersDetailsScreen({super.key});

  @override
  State<OrdersDetailsScreen> createState() => _OrdersDetailsScreenState();
}

class _OrdersDetailsScreenState extends State<OrdersDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Order Details",
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
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary, // Adjust opacity for a blush effect
                        offset: const Offset(0, 0), // Move the shadow downwards
                        blurRadius: 5, // Adjust blur radius as needed
                        spreadRadius: 0, // Adjust spread radius as needed
                        blurStyle: BlurStyle.outer,
                      )
                    ]),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //details
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Shree Shyam Store",
                          style: KTextStyle.K_14,
                        ),
                        Text(
                          "Hawrah",
                          style: KTextStyle.K_10,
                        ),
                      ],
                    ),
                    //figure
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RectangularButton(
                            title: "27 jul 24", color: AppColor.yellow),
                        SizedBox(
                          height: 4,
                        ),
                        RectangularButton(
                            title: "PENDING", color: AppColor.skyBlueButton),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 3),
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                    child: Text(
                                      "Roli / KumKum Powder",
                                      style: KTextStyle.K_16,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      RectangularButton(
                                          title: "Bottle",
                                          color: AppColor.skyBlueButton),
                                      RectangularButton(
                                          title: "25 GM",
                                          color: AppColor.yellowButton),
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
                                ],
                              ),
                            ],
                          ),
                        );
                      })),
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlexiableRectangularButton(
                        title: "MARK COMPLETED",
                        width: 200,
                        height: 40,
                        color: AppColor.brown,
                        onPress: () {}),
                    SqureIconButton(
                        icon: const Icon(Icons.print, color: AppColor.white),
                        color: AppColor.brown,
                        onPress: () {})
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
