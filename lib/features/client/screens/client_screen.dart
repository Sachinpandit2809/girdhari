import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/features/client/controller/client_provider_controller.dart';
import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/features/client/screens/edit_client_screen.dart';
import 'package:girdhari/features/expenses/controller/expenses_provider.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:girdhari/widgets/common/flexiable_rectangular_button.dart';

import 'package:girdhari/widgets/common/rectangular_button.dart';
import 'package:girdhari/widgets/common/search_k_textformfield.dart';
import 'package:girdhari/widgets/common/squre_icon_button.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/features/client/screens/add_client_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  TextEditingController searchClientController = TextEditingController();
  final clientCollectionRef =
      FirebaseFirestore.instance.collection('clientStore');
  final firestoreSnapshot =
      FirebaseFirestore.instance.collection("clientStore").snapshots();

  @override
  void dispose() {
    searchClientController.dispose();
    super.dispose();
  }

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
                    child: SearchKTextformfield(
                        onChange: (p0) {
                          setState(() {});
                        },
                        controller: searchClientController,
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
            StreamBuilder<QuerySnapshot>(
              stream: firestoreSnapshot,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  Utils().toastErrorMessage("error during Communication");
                }
                if (searchClientController.text.isEmpty) {}
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ClientModel clientData = ClientModel.fromJson(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>);

                          if (searchClientController.text.isEmpty) {
                            return InkWell(
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Consumer<ClientProviderController>(
                                          builder: (context,
                                              clientProviderController, _) {
                                        return AlertDialog(
                                          content: SizedBox(
                                            height: 100,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Text(
                                                    "are you sure want to delete?"),
                                                FlexiableRectangularButton(
                                                    title: "delete",
                                                    width: 140,
                                                    height: 40,
                                                    color: AppColor.brownRed,
                                                    loading:
                                                        clientProviderController
                                                            .loading,
                                                    onPress: () {
                                                      clientProviderController
                                                          .setLoading(true);

                                                      clientProviderController
                                                          .deleteClient(
                                                              clientData.id);
                                                    })
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    });
                              },
                              onTap: () {
                                Get.to(
                                    EditClientScreen(clientData: clientData));
                              },
                              child: Container(
                                // height: 90,
                                // width: 330,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 3),
                                margin: const EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //details
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          clientData.clientName,
                                          style: KTextStyle.K_14,
                                        ),
                                        Text(
                                          clientData.address,
                                          // softWrap: true,
                                          style: KTextStyle.K_E_10,
                                        ),
                                      ],
                                    ),
                                    //figure
                                    Column(
                                      children: [
                                        RectangularButton(
                                            title:
                                                "\u{20B9} ${clientData.dueAmount}",
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
                                                  FlutterPhoneDirectCaller
                                                      .callNumber(clientData
                                                          .phoneNumber
                                                          .toString());
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
                                                      "https://wa.me/91${clientData.phoneNumber}"));
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
                          if (clientData.clientName.toLowerCase().contains(
                                  searchClientController.text.toLowerCase()) ||
                              clientData.address.toLowerCase().contains(
                                  searchClientController.text.toLowerCase())) {
                            return InkWell(
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Consumer<ClientProviderController>(
                                          builder: (context,
                                              clientProviderController, _) {
                                        return AlertDialog(
                                          content: SizedBox(
                                            height: 100,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Text(
                                                    "are you sure want to delete?"),
                                                FlexiableRectangularButton(
                                                    title: "delete",
                                                    width: 140,
                                                    height: 40,
                                                    color: AppColor.brownRed,
                                                    loading:
                                                        clientProviderController
                                                            .loading,
                                                    onPress: () {
                                                      clientProviderController
                                                          .setLoading(true);

                                                      clientProviderController
                                                          .deleteClient(
                                                              clientData.id);
                                                    })
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    });
                              },
                              onTap: () {
                                Get.to(
                                    EditClientScreen(clientData: clientData));
                              },
                              child: Container(
                                // height: 90,
                                // width: 330,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 3),
                                margin: const EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //details
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            title:
                                                "\u{20B9} ${clientData.dueAmount.toString()}",
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
                                                  FlutterPhoneDirectCaller
                                                      .callNumber(clientData
                                                          .phoneNumber
                                                          .toString());
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
                          return Container();
                        }));
              },
            )
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
