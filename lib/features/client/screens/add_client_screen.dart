import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:girdhari/features/client/controller/client_controller.dart';
import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/features/dashboard_screen.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/k_text_form_field.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:uuid/uuid.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  TextEditingController clientNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController referredByController = TextEditingController();
  final ClientController _clientController = ClientController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void dispose() {
    clientNameController.dispose();
    phoneNumberController.dispose();
    referredByController.dispose();
    addressController.dispose();

    super.dispose();
  }

  //.........................................................................................
  void _addClient() async {
    setState(() {
      loading = true;
    });
    String id = const Uuid().v4();
    ClientModel client = ClientModel(
        id: id,
        clientName: clientNameController.text,
        phoneNumber: int.parse(phoneNumberController.text),
        address: addressController.text,
        referredBy: referredByController.text);
    await _clientController.addClient(client).then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastSuccessMessage("Client added SucCesfully!");
      Get.to(const DashBoardScreen());
    }).onError(
      (error, stackTrace) {
        Utils().toastErrorMessage(" Failed to Add Client!");
      },
    );
  }

  //.........................................................................................

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Client",
          style: KTextStyle.K_20,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text(
                    "Enter details",
                    style: KTextStyle.K_14,
                  ),
                ),
                KTextFormField(
                    validator: (value) {
                      if (clientNameController.text.isEmpty) {
                        return "enter client";
                      }
                      return null;
                    },
                    controller: clientNameController,
                    hintText: "Client Name"),
                KTextFormField(
                    validator: (value) {
                      if (phoneNumberController.text.isEmpty) {
                        return "enter phone number";
                      }
                      return null;
                    },
                    controller: phoneNumberController,
                    hintText: "phone Number"),
                KTextFormField(
                    validator: (value) {
                      if (addressController.text.isEmpty) {
                        return "enter adress";
                      }
                      return null;
                    },
                    controller: addressController,
                    hintText: "Address"),
                KTextFormField(
                    validator: (value) {
                      // if (referredByController.text.isEmpty) {
                      //   return "enter quantity";
                      // }
                      return null;
                    },
                    controller: referredByController,
                    hintText: "Referred By (optional)"),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: FlexiableRectangularButton(
                      title: "SUBMIT",
                      width: 120,
                      height: 44,
                      color: AppColor.brown,
                      loading: loading,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          _addClient();
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
