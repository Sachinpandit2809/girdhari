import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/features/client/controller/client_controller.dart';
import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/features/dashboard_screen.dart';
import 'package:girdhari/utils/utils.dart';

import 'package:girdhari/widgets/common/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/common/k_text_form_field.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';

// ignore: unused_import
import 'package:girdhari/features/product/screens/edit_product_screen.dart';

class EditClientScreen extends StatefulWidget {
  final ClientModel clientData;
  const EditClientScreen({super.key, required this.clientData});

  @override
  State<EditClientScreen> createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditClientScreen> {
  TextEditingController clientNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController referredByController = TextEditingController();
  TextEditingController dueAmountController = TextEditingController();

  bool loading = false;
  final ClientController _editClientController = ClientController();
  @override
  void initState() {
    clientNameController.text = widget.clientData.clientName;
    phoneNumberController.text = widget.clientData.phoneNumber.toString();
    addressController.text = widget.clientData.address;
    referredByController.text = widget.clientData.referredBy ?? "";
    dueAmountController.text = widget.clientData.dueAmount.toString();

    super.initState();
  }

  void _editClient() async {
    setState(() {
      loading = true;
    });
    String id = widget.clientData.id;
    ClientModel client = ClientModel(
        id: id,
        clientName: clientNameController.text,
        phoneNumber: int.parse(phoneNumberController.text),
        address: addressController.text,
        dueAmount: double.parse(dueAmountController.text),
        referredBy: referredByController.text);

    await _editClientController.editClient(client).then((onValue) {
      setState(() {
        loading = false;
      });
      Get.to(() => const DashBoardScreen());
      Utils().toastSuccessMessage("Client Updated");
    }).onError(
      (error, stackTrace) {
        setState(() {
          loading = false;
        });
        Utils().toastErrorMessage(error.toString());
      },
    );
  }

  @override
  void dispose() {
    clientNameController.dispose();
    phoneNumberController.dispose();
    referredByController.dispose();
    addressController.dispose();
    dueAmountController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "Edit Client",
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
                 Padding(
                  padding:const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text(
                    "Enter details",
                    style: KTextStyle.K_14,
                  ),
                ),
                KTextFormField(
                    validator: (value) {
                      if (clientNameController.text.isEmpty) {
                        return "enter client name";
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
                    controller: dueAmountController,
                    hintText: "enter due amount"),
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
                          _editClient();
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
