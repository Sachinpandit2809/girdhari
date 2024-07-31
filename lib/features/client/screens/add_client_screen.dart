import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/features/client/controller/client_controller.dart';
import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/features/client/screens/client_screen.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/k_text_form_field.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/features/client/screens/edit_client_screen.dart';

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
  bool loading = false;
  final ClientController _clientController = ClientController();
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
    String id = DateTime.now().millisecondsSinceEpoch.toString();
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
      Get.to(const ClientScreen());
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
                  onPress: _addClient
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
