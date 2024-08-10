import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:girdhari/features/expenses/controller/expenses_provider.dart';
import 'package:girdhari/features/expenses/model/expenses_model.dart';
import 'package:girdhari/widgets/common/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/common/k_text_form_field.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/widgets/common/search_k_textformfield.dart';
import 'package:girdhari/widgets/expenses/expense_card.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController; // Add TabController instance

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

  @override
  void dispose() {
    searchExpensesController.dispose();
    venderDetailsController.dispose();
    expenseTitleController.dispose();
    amountController.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expenses",
          style: KTextStyle.K_20,
        ),
        actions: [
          FlexiableRectangularButton(
              title: "\u{20B9} ${context.watch<ExpensesProvider>().totalPrice}",
              textColor: Colors.black,
              width: 130,
              height: 30,
              color: AppColor.skyBlueButton,
              onPress: () {})
        ],
      ),
      body: Consumer<ExpensesProvider>(builder: (context, expenseProvider, _) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchKTextformfield(
                  onChange: (p0) {
                    setState(() {});
                  },
                  controller: searchExpensesController,
                  hintText: "Search Expenses"),
              StreamBuilder<List<ExpensesModel>>(
                stream: expenseProvider.fetchExpenses(),
                // stream: context.read<Stream<List<ExpensesModel>>>(),
                builder: (context, value) {
                  return value.data == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: value.data!.length,
                              itemBuilder: (context, index) {
                                ExpensesModel expense = value.data![index];

                                if (expense.expensesTitle
                                        .toLowerCase()
                                        .contains(searchExpensesController.text
                                            .toLowerCase()) ||
                                    expense.venderDetail.toLowerCase().contains(
                                        searchExpensesController.text
                                            .toLowerCase())) {
                                  return ExpenseCard(
                                      expense: expense,
                                      expenseProvider: expenseProvider);
                                } else
                                  return SizedBox();
                              }),
                        );

                  ;
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
          addBottomSheet();
        },
        child: const Icon(
          Icons.add,
          color: AppColor.white,
          size: 30,
        ),
      ),
    );
  }

  void addBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Consumer<ExpensesProvider>(builder: (context, expProvider, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 510,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        KTextFormField(
                            validator: (value) {
                              if (venderDetailsController.text.isEmpty) {
                                return "enter quantity vender details";
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
                          controller: amountController,
                          hintText: "enter amount",
                          keyBoard: TextInputType.number,
                        ),
                        Center(
                          child: Consumer<ExpensesProvider>(
                            builder: (context, categoryProvider, child) {
                              return ToggleButtons(
                                isSelected: [
                                  categoryProvider.selectedCategory ==
                                      'Raw Material',
                                  categoryProvider.selectedCategory ==
                                      'Packaging',
                                  categoryProvider.selectedCategory == 'Others',
                                ],
                                onPressed: (int index) {
                                  switch (index) {
                                    case 0:
                                      categoryProvider
                                          .setCategory('Raw Material');
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text('Raw Material'),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text('Packaging'),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
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
                          validator: (value) {
                            if (_dateController.text.isEmpty) {
                              return "select date";
                            }
                            return null;
                          },
                          readOnly: true,
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
                          loading: expProvider.loading,
                          color: AppColor.brown,
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              expProvider.setLoading(true);
                              ExpensesModel expense = ExpensesModel(
                                  id: const Uuid().v4(),
                                  venderDetail: venderDetailsController.text,
                                  expensesTitle: expenseTitleController.text,
                                  type: expProvider.selectedCategory,
                                  amount: double.parse(amountController.text),
                                  expensesDate: _dateController.text);
                              expProvider.addExpenses(expense);
                            }
                          },
                        )
                      ]),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
