import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/features/client/controller/client_controller.dart';
import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/features/dashboard_screen.dart';
import 'package:girdhari/utils/utils.dart';

import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/k_text_form_field.dart';
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
  bool loading = false;
  final ClientController _editClientController = ClientController();
  @override
  void initState() {
    clientNameController.text = widget.clientData.clientName;
    phoneNumberController.text = widget.clientData.phoneNumber.toString();
    addressController.text = widget.clientData.address;
    referredByController.text = widget.clientData.referredBy;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Client",
          style: KTextStyle.K_20,
        ),
      ),
      body: SingleChildScrollView(
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
                  controller: clientNameController, hintText: "Client Name"),
              KTextFormField(
                  controller: phoneNumberController, hintText: "phone Number"),
              KTextFormField(
                  controller: addressController, hintText: "Address"),
              KTextFormField(
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
                    onPress: _editClient),
              )
            ],
          ),
        ),
      ),
    );
  }
}
