import 'package:flutter/material.dart';
// import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';

// ignore: must_be_immutable
class FlexiableRectangularButton extends StatelessWidget {
  final String title;
  final Color color;
  final double height, width;
  final Color? textColor;
  final VoidCallback onPress;

  FlexiableRectangularButton(
      {super.key,
      required this.title,
      required this.width,
      required this.height,
      required this.color,
      required this.onPress,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
        child: Center(
            child: Text(
          title,
          style: KTextStyle.K_15.copyWith(color: textColor),
        )),
      ),
    );
  }
}
