import 'package:flutter/material.dart';

class SqureIconButton extends StatelessWidget {
  final Widget icon;
  final Color color;
  final VoidCallback onPress;

   const SqureIconButton(
      {super.key,
      required this.icon,
      required this.color,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 5, 6, 0),
        height: 32,
        width: 33,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
