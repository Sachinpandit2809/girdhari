import 'package:flutter/material.dart';

class KTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyBoard;

  const KTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.keyBoard = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: keyBoard,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(25, 0, 10, 0),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD9D9D9)),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          hintText: hintText,
        ),
      ),
    );
  }
}
