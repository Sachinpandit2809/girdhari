import 'package:flutter/material.dart';

class SearchKTextformfield extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChange; // Added type annotation

  const SearchKTextformfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChange,
  });

  @override
  State<SearchKTextformfield> createState() => _KTextFormFieldState();
}

class _KTextFormFieldState extends State<SearchKTextformfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: widget.controller,
        onChanged: widget.onChange, // Corrected this line
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(25, 0, 10, 0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
