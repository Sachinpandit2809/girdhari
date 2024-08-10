import 'package:flutter/material.dart';

class LebelKTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyBoard;
  final String label;

  const LebelKTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyBoard = TextInputType.text,
    required this.label

  });

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
              labelText: label,
          hintText: hintText,
        ),
      ),
    );
  }
}
