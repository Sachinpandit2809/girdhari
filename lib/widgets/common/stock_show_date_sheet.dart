import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girdhari/widgets/common/rectangular_button.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class StockShowDateSheet extends StatelessWidget {
  String date;
  String buttonTitle;
  String count;

  StockShowDateSheet(
      {super.key,
      required this.date,
      required this.buttonTitle,
      required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          SizedBox(
            width: Get.width / 3,
            child: Text(
              date,
              // DateFormat('dd/MM/yyyy').format(date),
              style: buttonTitle == "created"
                  ? KTextStyle.K_20
                      .copyWith(color: const Color.fromARGB(255, 79, 209, 76))
                  : KTextStyle.K_20,
            ),
          ),
          SizedBox(
            width: Get.width / 3,
            child: RectangularButton(
                title: buttonTitle,
                color: buttonTitle == "created"
                    ? AppColor.lowGreen
                    : AppColor.yellow),
          ),
          Spacer(),
          Text(
            count,
            style: buttonTitle == "created"
                ? KTextStyle.K_20
                    .copyWith(color: const Color.fromARGB(255, 79, 209, 76))
                : KTextStyle.K_20,
          )
        ],
      ),
    );
  }
}
