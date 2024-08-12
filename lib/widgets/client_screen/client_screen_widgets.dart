import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/features/client/controller/client_provider_controller.dart';
import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/features/client/screens/client_details.dart';
import 'package:girdhari/features/client/screens/edit_client_screen.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/widgets/common/rectangular_button.dart';
import 'package:girdhari/widgets/common/squre_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/flexiable_rectangular_button.dart';

class ClientScreenWidgets extends StatelessWidget {
  final ClientModel clientData;
  final ClientProviderController clientProviderController;
  const ClientScreenWidgets(
      {super.key,
      required this.clientData,
      required this.clientProviderController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return Consumer<ClientProviderController>(
                  builder: (context, clientProviderController, _) {
                return AlertDialog(
                  content: SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Edit client details",
                          style: KTextStyle.K_14,
                        ),
                        FlexiableRectangularButton(
                            title: "edit",
                            width: 140,
                            height: 40,
                            color: AppColor.green,
                            onPress: () {
                              Get.back();
                              Get.to(EditClientScreen(clientData: clientData));
                            }),
                        const Divider(),
                        Text("Delete this Client", style: KTextStyle.K_14),
                        FlexiableRectangularButton(
                            title: "delete",
                            width: 140,
                            height: 40,
                            color: AppColor.brownRed,
                            loading: clientProviderController.loading,
                            onPress: () {
                              clientProviderController.setLoading(true);
                              ClientModel softDelete = ClientModel(
                                  id: clientData.id,
                                  clientName: clientData.clientName,
                                  phoneNumber: clientData.phoneNumber,
                                  address: clientData.address,
                                  is_deleted: true,
                                  referredBy: clientData.referredBy);

                              clientProviderController.deleteClient(softDelete);
                            })
                      ],
                    ),
                  ),
                );
              });
            });
      },
      onTap: () {
        Get.to(ClientDetails(client: clientData));
        clientProviderController.setClient(clientData);
      },
      child: Container(
        // height: 90,
        // width: 330,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //details
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clientData.clientName,
                  style: KTextStyle.K_14,
                ),
                Text(
                  clientData.address,
                  //softWrap: true,
                  style: KTextStyle.K_E_10,
                ),
              ],
            ),
            //figure
            Column(
              children: [
                RectangularButton(
                    title: "\u{20B9} ${clientData.dueAmount.toString()}",
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
                        onPress: () {
                          FlutterPhoneDirectCaller.callNumber(
                              clientData.phoneNumber.toString());
                        }),
                    SqureIconButton(
                        icon: const Icon(
                          Icons.comment,
                          color: AppColor.white,
                          size: 18,
                        ),
                        color: AppColor.yellowButton,
                        onPress: () {
                          launchUrl(Uri.parse(
                              "https://wa.me/+91 ${clientData.phoneNumber}"));
                        })
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
