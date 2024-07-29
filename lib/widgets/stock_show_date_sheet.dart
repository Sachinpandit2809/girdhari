import 'package:flutter/material.dart';
import 'package:girdhari/widgets/rectangular_button.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: KTextStyle.K_20,
          ),
          RectangularButton(title: buttonTitle, color: AppColor.yellow),
          Text(
            count,
            style: KTextStyle.K_20,
          )
        ],
      ),
    );
  }
}
