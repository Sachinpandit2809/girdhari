import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girdhari/features/app_lock/app_password_controller.dart';
import 'package:girdhari/features/dashboard_screen.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:girdhari/widgets/common/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/common/k_text_form_field.dart';
import 'package:provider/provider.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController lockController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    lockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('password').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              Utils().toastErrorMessage("error During Communication");
            }
            var lock = snapshot.data!.docs.first['password'];
            debugPrint(
                // ignore: prefer_interpolation_to_compose_strings
                ".............." + snapshot.data!.docs.first['password']);

            return Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/png/splash_logo.png"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please enter your password",
                          style: KTextStyle.K_20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        KTextFormField(
                            keyBoard: TextInputType.number,
                            controller: lockController,
                            validator: (value) {
                              if (lockController.text.isEmpty) {
                                return "enter password";
                              }
                              return null;
                            },
                            hintText: "password"),
                        const SizedBox(
                          height: 10,
                        ),
                        Consumer<AppPasswordController>(
                            builder: (context, appPasswordController, _) {
                          return ConfermRectangularButton(
                              title: "varify",
                              width: 200,
                              height: 40,
                              color: AppColor.brown,
                              loading: loading,
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  // appPasswordController
                                  //     .setAppPasswordLoading(true);
                                  setState(() {
                                    loading = true;
                                  });
                                  if (lock == lockController.text) {
                                    Get.to(() => const DashBoardScreen());
                                    // appPasswordController
                                    //     .setAppPasswordLoading(false);
                                    lockController.text = '';
                                    setState(() {
                                      loading = false;
                                    });
                                  } else {
                                    setState(() {
                                      loading = false;
                                    });
                                    lockController.text = '';

                                    Utils().toastErrorMessage(
                                        " please enter correct password");
                                    // appPasswordController
                                    //     .setAppPasswordLoading(false);
                                  }
                                }
                              });
                        })
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
