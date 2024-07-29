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
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: 29,
      width: 30,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        title,
        style: KTextStyle.K_10.copyWith(color:AppColor.white),
      )),
    );
  }
}
