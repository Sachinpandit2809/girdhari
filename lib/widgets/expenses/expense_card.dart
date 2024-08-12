import 'package:flutter/material.dart';
import 'package:girdhari/features/expenses/controller/expenses_provider.dart';
import 'package:girdhari/features/expenses/model/expenses_model.dart';
import 'package:girdhari/features/expenses/screen/edit_expenses.dart';
import 'package:girdhari/widgets/common/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/common/rectangular_button.dart';
import 'package:provider/provider.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';

class ExpenseCard extends StatelessWidget {
  ExpensesModel expense;
  ExpensesProvider expenseProvider;

  ExpenseCard(
      {super.key, required this.expense, required this.expenseProvider});
  @override
  Widget build(BuildContext context) {
    if (expense.expensesTitle.isEmpty && expense.venderDetail.isEmpty) {
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("are you sure want to delete"),
                          FlexiableRectangularButton(
                              title: "delete",
                              width: 140,
                              height: 40,
                              color: AppColor.brownRed,
                              loading: expenseProvider.deleteLoading,
                              onPress: () {
                                expense.setDeleteLoading(true);
                                // expense.deleteExpense(expense.id);
                              })
                        ],
                      ),
                    ),
                  );
                });
              });
        },
        onTap: () {
        

          Get.to(() => EditExpenses(expenseData: expense));
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .primary, // Adjust opacity for a blush effect
                  offset: const Offset(0, 0), // Move the shadow downwards
                  blurRadius: 5, // Adjust blur radius as needed
                  spreadRadius: 0, // Adjust spread radius as needed
                  blurStyle: BlurStyle.outer,
                )
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //details
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.venderDetail,
                    style: KTextStyle.K_14,
                  ),
                  Text(
                    expense.expensesTitle,
                    style: KTextStyle.K_10,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      RectangularButton(
                          title: expense.type, color: AppColor.skyBlueButton),
                      RectangularButton(
                          title: expense.expensesDate, color: AppColor.yellow),
                    ],
                  )
                ],
              ),
              //figure
              RectangularButton(
                  onPress: () {},
                  title: "\u{20B9} ${expense.amount}",
                  color: AppColor.skyBlueButton)
            ],
          ),
        ),
      );
    }

    return InkWell(
      onLongPress: () {
        debugPrint("....................triggred");
        showDialog(
            context: context,
            builder: (context) {
              return Consumer<ExpensesProvider>(
                  builder: (context, expenseP, _) {
                return AlertDialog(
                  content: SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("are you sure want to delete"),
                        FlexiableRectangularButton(
                            title: "delete",
                            width: 140,
                            height: 40,
                            color: AppColor.brownRed,
                            loading: expenseProvider.deleteLoading,
                            onPress: () {
                              expenseP.setDeleteLoading(true);
                              expenseP.deleteExpense(expense.id);
                            })
                      ],
                    ),
                  ),
                );
              });
            });
      },
      onTap: () {
        Get.to(EditExpenses(expenseData: expense));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context)
                    .colorScheme
                    .primary, // Adjust opacity for a blush effect
                offset: const Offset(0, 0), // Move the shadow downwards
                blurRadius: 5, // Adjust blur radius as needed
                spreadRadius: 0, // Adjust spread radius as needed
                blurStyle: BlurStyle.outer,
              )
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //details
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.venderDetail,
                  style: KTextStyle.K_14,
                ),
                Text(
                  expense.expensesTitle,
                  style: KTextStyle.K_10,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    RectangularButton(
                        title: expense.type, color: AppColor.skyBlueButton),
                    RectangularButton(
                        title: expense.expensesDate, color: AppColor.yellow),
                  ],
                )
              ],
            ),
            //figure
            RectangularButton(
                onPress: () {},
                title: "\u{20B9} ${expense.amount}",
                color: AppColor.skyBlueButton)
          ],
        ),
      ),
    );
  }
}
