import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/features/client/controller/client_controller.dart';
import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/features/orders/controller/bill_provider.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/widgets/common/squre_icon_button.dart';

class BillCard extends StatelessWidget {
  final BillProvider newBillProvider;
  final ClientModel client;
  final TextEditingController SearchClientController;
  const BillCard(
      {super.key,
      required this.SearchClientController,
      required this.newBillProvider,
      required this.client});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // newBillProvider
        //         .selectedClient =
        //     null;
        newBillProvider.setClient(client);

        SearchClientController.text = client.clientName;
        debugPrint(newBillProvider.selectedClient!.toString());
        Get.back();
      },
      //TODO  remove this logic
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
        // height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            // border: Border.all(
            //   color: Theme.of(context).colorScheme.primary,
            // ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context)
                    .colorScheme
                    .primary, // Adjust opacity for a blush effect
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client.clientName,
                  style: KTextStyle.K_14,
                ),
                Text(
                  client.address,
                  style: KTextStyle.K_10,
                ),
              ],
            ),

            SqureIconButton(
                icon: const Icon(
                  Icons.close,
                  color: AppColor.white,
                  size: 20,
                ),
                color: AppColor.brown,
                onPress: () {
                  Get.back();
                })
          ],
        ),
      ),
    );
  }
}
