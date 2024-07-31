import "package:flutter/material.dart";
import "package:girdhari/resource/app_color.dart";
import "package:girdhari/resource/k_text_style.dart";

class SmallSquareButton extends StatelessWidget {
  final String title;
  final Color color;

  const SmallSquareButton(
      {super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: 33,
      width: 34,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
      child: Center(
          child: Text(
        title,
        style: KTextStyle.K_10.copyWith(color: AppColor.white),
      )),
    );
  }
}
