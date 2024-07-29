import 'package:flutter/material.dart';
import 'package:girdhari/resource/k_text_style.dart';

class RectangularButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color textColor;
  final VoidCallback? onPress;

  const RectangularButton({
    super.key,
    required this.title,
    required this.color,
    this.textColor = Colors.black,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        height: 22,
        width: 71,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          title,
          style: KTextStyle.K_10.copyWith(color: textColor),
        )),
      ),
    );
  }
}
