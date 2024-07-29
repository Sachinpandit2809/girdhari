import 'package:flutter/material.dart';

class KTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const KTextFormField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(25, 0, 10, 0),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD9D9D9)),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          hintText: hintText,
        ),
      ),
    );
  }
}
