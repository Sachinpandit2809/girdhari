import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/features/client/controller/client_provider_controller.dart';
import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:girdhari/widgets/client_screen/client_screen_widgets.dart';

import 'package:girdhari/widgets/common/search_k_textformfield.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/features/client/screens/add_client_screen.dart';
import 'package:provider/provider.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  TextEditingController searchClientController = TextEditingController();
  // final clientCollectionRef =
  //     FirebaseFirestore.instance.collection('clientStore');
  final firestoreSnapshot = FirebaseFirestore.instance
      .collection("clientStore")
      .where("is_deleted", isEqualTo: false)
      .snapshots();

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
        title:  Text(
          "Client ",
          style: KTextStyle.K_20,
        ),
      ),
      body: Consumer<ClientProviderController>(
          builder: (context, clientProviderController, _) {
        return Padding(
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
                              ClientScreenWidgets(
                                  clientData: clientData,
                                  clientProviderController:
                                      clientProviderController);
                            }
                            if (clientData.clientName.toLowerCase().contains(
                                    searchClientController.text
                                        .toLowerCase()) ||
                                clientData.address.toLowerCase().contains(
                                    searchClientController.text
                                        .toLowerCase())) {
                              return ClientScreenWidgets(
                                  clientData: clientData,
                                  clientProviderController:
                                      clientProviderController);
                            }
                            return const SizedBox();
                          }));
                },
              )
            ],
          ),
        );
      }),
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
