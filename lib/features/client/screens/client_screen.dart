import 'package:flutter/material.dart';

import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:girdhari/widgets/k_text_form_field.dart';
import 'package:girdhari/widgets/rectangular_button.dart';
import 'package:girdhari/widgets/squre_icon_button.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/features/client/screens/add_client_screen.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  TextEditingController searchProductController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Client ",
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
                    child: KTextFormField(
                        controller: searchProductController,
                        hintText: "Search Client")),
                IconButton(
                  icon: Image.asset('assets/images/png/icon_filter.png'),
                  onPressed: () {
                    //function
                  },
                )
              ],
            ),
            const SizedBox(
              height: 30,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //details
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                            Column(
                              children: [
                                const RectangularButton(
                                    title: "\u{20B9}" "15420",
                                    color: AppColor.skyBlueButton),
                                Row(
                                  children: [
                                    SqureIconButton(
                                        icon: const Icon(
                                          Icons.call,
                                          color: AppColor.white,
                                          size: 18,
                                        ),
                                        color: AppColor.skyBlue,
                                        onPress: () {}),
                                    SqureIconButton(
                                        icon: const Icon(
                                          Icons.comment,
                                          color: AppColor.white,
                                          size: 18,
                                        ),
                                        color: AppColor.yellowButton,
                                        onPress: () {})
                                  ],
                                )
                              ],
                            ),
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
         
          Get.to(const AddClientScreen());
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
