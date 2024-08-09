import 'package:flutter/material.dart';
import 'package:girdhari/resource/app_color.dart';
// import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';

// ignore: must_be_immutable
class FlexiableRectangularButton extends StatelessWidget {
  final String title;
  final Color color;
  final double height, width;
  final Color? textColor;
  final VoidCallback onPress;
  final bool loading;

  const FlexiableRectangularButton(
      {super.key,
      required this.title,
      required this.width,
      required this.height,
      required this.color,
      this.loading = false,
      required this.onPress,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
        child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    color: AppColor.white,
                    strokeWidth: 2,
                  )
                : Text(
                    title,
                    style: KTextStyle.K_15.copyWith(color: textColor),
                  )),
      ),
    );
  }
}

// ignore: must_be_immutable
class ConfermRectangularButton extends StatelessWidget {
  final String title;
  final Color color;
  final double height, width;
  final Color? textColor;
  final VoidCallback onPress;
  final bool loading;

  const ConfermRectangularButton(
      {super.key,
      required this.title,
      required this.width,
      required this.height,
      required this.color,
      this.loading = false,
      required this.onPress,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Center(
              child: loading
                  ? const CircularProgressIndicator(
                      color: AppColor.white,
                      strokeWidth: 2,
                    )
                  : Text(
                      title,
                      style: KTextStyle.K_12.copyWith(color: textColor),
                    )),
        ),
      ),
    );
  }
}
