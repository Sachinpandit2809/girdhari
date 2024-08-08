import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girdhari/features/expenses/controller/expenses_controller.dart';
import 'package:girdhari/features/expenses/controller/expenses_provider.dart';
import 'package:girdhari/features/expenses/model/expenses_model.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/k_text_form_field.dart';
import 'package:provider/provider.dart';

class EditExpenses extends StatefulWidget {
  final ExpensesModel expenseData;
  const EditExpenses({super.key, required this.expenseData});

  @override
  State<EditExpenses> createState() => _EditExpensesState();
}

class _EditExpensesState extends State<EditExpenses> {
  bool loading = false;
  TextEditingController searchExpensesController = TextEditingController();
  TextEditingController venderDetailsController = TextEditingController();
  TextEditingController expenseTitleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final fireStore =
      FirebaseFirestore.instance.collection("expensesStore").snapshots();
  final expencesCollectionRefernce =
      FirebaseFirestore.instance.collection("expensesStore");

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  initState() {
    super.initState();
    venderDetailsController.text = widget.expenseData.venderDetail;
    expenseTitleController.text = widget.expenseData.expensesTitle;
    amountController.text = widget.expenseData.amount.toString();
    _dateController.text = widget.expenseData.expensesDate;
  }

  String? selectedCategory;

  get type => selectedCategory;
  double totalPrice = 0;

  void editExpenses() async {
    setState(() {
      loading = true;
    });

    final exPvdr = Provider.of<ExpensesProvider>(context, listen: false);

    ExpensesModel expense = ExpensesModel(
        id: widget.expenseData.id,
        venderDetail: venderDetailsController.text,
        expensesTitle: expenseTitleController.text,
        type: exPvdr.selectedCategory,
        amount: double.parse(amountController.text),
        expensesDate: _dateController.text);
    await ExpensesController().editExpense(expense).then((onValue) {
      setState(() {
        loading = false;
      });
      Utils().toastSuccessMessage("expenses added");
      Get.back();
    }).onError(
      (error, stackTrace) {
        setState(() {
          loading = false;
        });
        Utils().toastErrorMessage(error.toString());
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Expenses",
          style: KTextStyle.K_20,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 510,
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    KTextFormField(
                        validator: (value) {
                          if (venderDetailsController.text.isEmpty) {
                            return "enter vender details";
                          }
                          return null;
                        },
                        controller: venderDetailsController,
                        hintText: "Enter Vender Details"),
                    KTextFormField(
                        validator: (value) {
                          if (expenseTitleController.text.isEmpty) {
                            return "enter expenses title";
                          }
                          return null;
                        },
                        controller: expenseTitleController,
                        hintText: "Enter Expense Title"),
                    KTextFormField(
                        validator: (value) {
                          if (amountController.text.isEmpty) {
                            return "enter amount";
                          }
                          return null;
                        },
                        keyBoard: TextInputType.number,
                        controller: amountController,
                        hintText: "Enter Amount"),
                    Center(
                      child: Consumer<ExpensesProvider>(
                        builder: (context, categoryProvider, child) {
                          return ToggleButtons(
                            isSelected: [
                              categoryProvider.selectedCategory ==
                                  'Raw Material',
                              categoryProvider.selectedCategory == 'Packaging',
                              categoryProvider.selectedCategory == 'Others',
                            ],
                            onPressed: (int index) {
                              switch (index) {
                                case 0:
                                  categoryProvider.setCategory('Raw Material');
                                  break;
                                case 1:
                                  categoryProvider.setCategory('Packaging');
                                  break;
                                case 2:
                                  categoryProvider.setCategory('Others');
                                  break;
                              }
                            },
                            selectedColor: Colors.white,
                            fillColor: Colors.blue,
                            color: Colors.black,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text('Raw Material'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text('Packaging'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text('Others'),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      validator: (value) {
                        if (_dateController.text.isEmpty) {
                          return "select Date";
                        }
                        return null;
                      },
                      onTap: () => _selectDate(context),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(25, 0, 10, 0),
                        labelText: 'Select Date',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FlexiableRectangularButton(
                      title: "SUBMIT",
                      width: 120,
                      height: 44,
                      loading: loading,
                      color: AppColor.brown,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          editExpenses();
                        }
                      },
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
