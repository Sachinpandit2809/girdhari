import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
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

  TextEditingController refferedByController = TextEditingController();

  @override
  void dispose() {

    clientNameController.dispose();
    phoneNumberController.dispose();
    refferedByController.dispose();
    addressController.dispose();

    super.dispose();
  }

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
                  controller: refferedByController,
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
                  onPress: () {
                 
                    Get.to(const EditClientScreen());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
