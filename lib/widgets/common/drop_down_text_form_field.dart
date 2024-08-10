import 'package:flutter/material.dart';

class DropDownTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator validator;

  const DropDownTextFormField({
    super.key,
    required this.validator,
    required this.controller,
    required this.hintText,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DropDownTextFormFieldState createState() => _DropDownTextFormFieldState();
}

class _DropDownTextFormFieldState extends State<DropDownTextFormField> {
  String? selectedValue;
  final List<String> items = ['Jar', 'Bottle', 'Pouch'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(25, 0, 10, 0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          hintText: widget.hintText,
          suffixIcon: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              icon: const Icon(Icons.arrow_drop_down),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue;
                  widget.controller.text = newValue!;
                });
              },
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
