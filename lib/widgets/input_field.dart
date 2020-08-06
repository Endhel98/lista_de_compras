import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final String hint;
  final Widget prefix;
  final TextInputType type;

  InputField({
    @required this.controller,
    this.hint,
    this.validator,
    this.prefix,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink[300],
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink[300],
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink[300],
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink[300],
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink[300],
          ),
        ),
        errorStyle: TextStyle(color: Colors.grey[300]),
        fillColor: Colors.pink[300],
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white),
        prefixIcon: prefix,
      ),
      style: TextStyle(fontSize: 16.0, color: Colors.white),
    );
  }
}
