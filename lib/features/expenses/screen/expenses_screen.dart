import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:girdhari/features/expenses/controller/expenses_provider.dart';
import 'package:girdhari/features/expenses/model/expenses_model.dart';
import 'package:girdhari/features/expenses/screen/edit_expenses.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:girdhari/widgets/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/k_text_form_field.dart';
import 'package:girdhari/widgets/rectangular_button.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/widgets/search_k_textformfield.dart';

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

  double totalPrice = 0;

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
              title: "\u{20B9} $totalPrice",
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
              StreamBuilder<QuerySnapshot>(
                stream: fireStore,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: Colors.amber,
                    );
                  }
                  if (snapshot.hasError) {
                    Utils().toastErrorMessage("error during Communication");
                  }

                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ExpensesModel expenses = ExpensesModel.fromJson(
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>);
                            //totalPrice = 0;
                            totalPrice += expenses.amount;
                            debugPrint(
                                "............................${totalPrice.toString()}");
                            if (expenses.expensesTitle.isEmpty &&
                                expenses.venderDetail.isEmpty) {
                              return InkWell(
                                onLongPress: () {
                                  debugPrint("....................triggred");
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Consumer<ExpensesProvider>(
                                            builder: (context, expense, _) {
                                          return AlertDialog(
                                            content: SizedBox(
                                              height: 100,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                      "are you sure want to delete"),
                                                  FlexiableRectangularButton(
                                                      title: "delete",
                                                      width: 140,
                                                      height: 40,
                                                      color: AppColor.brownRed,
                                                      loading: expenseProvider
                                                          .deleteLoading,
                                                      onPress: () {
                                                        expense
                                                            .setDeleteLoading(
                                                                true);
                                                        expense.deleteExpense(
                                                            expenses.id);
                                                      })
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                      });
                                },
                                onTap: () {
                                  debugPrint("....................triggred");

                                  Get.to(() =>
                                      EditExpenses(expenseData: expenses));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 4),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary, // Adjust opacity for a blush effect
                                          offset: const Offset(0,
                                              0), // Move the shadow downwards
                                          blurRadius:
                                              5, // Adjust blur radius as needed
                                          spreadRadius:
                                              0, // Adjust spread radius as needed
                                          blurStyle: BlurStyle.outer,
                                        )
                                      ]),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //details
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            expenses.venderDetail,
                                            style: KTextStyle.K_14,
                                          ),
                                          Text(
                                            expenses.expensesTitle,
                                            style: KTextStyle.K_10,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              RectangularButton(
                                                  title: expenses.type,
                                                  color:
                                                      AppColor.skyBlueButton),
                                              RectangularButton(
                                                  title: expenses.expensesDate,
                                                  color: AppColor.yellow),
                                            ],
                                          )
                                        ],
                                      ),
                                      //figure
                                      RectangularButton(
                                          onPress: () {},
                                          title: "\u{20B9} ${expenses.amount}",
                                          color: AppColor.skyBlueButton)
                                    ],
                                  ),
                                ),
                              );
                            }

                            if (expenses.expensesTitle.toLowerCase().contains(
                                    searchExpensesController.text
                                        .toLowerCase()) ||
                                expenses.venderDetail.toLowerCase().contains(
                                    searchExpensesController.text
                                        .toLowerCase())) {
                              return InkWell(
                                onLongPress: () {
                                  debugPrint("....................triggred");
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Consumer<ExpensesProvider>(
                                            builder: (context, expense, _) {
                                          return AlertDialog(
                                            content: SizedBox(
                                              height: 100,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                      "are you sure want to delete"),
                                                  FlexiableRectangularButton(
                                                      title: "delete",
                                                      width: 140,
                                                      height: 40,
                                                      color: AppColor.brownRed,
                                                      loading: expenseProvider
                                                          .deleteLoading,
                                                      onPress: () {
                                                        expense
                                                            .setDeleteLoading(
                                                                true);
                                                        expense.deleteExpense(
                                                            expenses.id);
                                                      })
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                      });
                                },
                                onTap: () {
                                  Get.to(EditExpenses(expenseData: expenses));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 4),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary, // Adjust opacity for a blush effect
                                          offset: const Offset(0,
                                              0), // Move the shadow downwards
                                          blurRadius:
                                              5, // Adjust blur radius as needed
                                          spreadRadius:
                                              0, // Adjust spread radius as needed
                                          blurStyle: BlurStyle.outer,
                                        )
                                      ]),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //details
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            expenses.venderDetail,
                                            style: KTextStyle.K_14,
                                          ),
                                          Text(
                                            expenses.expensesTitle,
                                            style: KTextStyle.K_10,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              RectangularButton(
                                                  title: expenses.type,
                                                  color:
                                                      AppColor.skyBlueButton),
                                              RectangularButton(
                                                  title: expenses.expensesDate,
                                                  color: AppColor.yellow),
                                            ],
                                          )
                                        ],
                                      ),
                                      //figure
                                      RectangularButton(
                                          onPress: () {},
                                          title: "\u{20B9} ${expenses.amount}",
                                          color: AppColor.skyBlueButton)
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
