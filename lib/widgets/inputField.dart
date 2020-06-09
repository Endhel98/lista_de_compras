import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;

  InputField({@required this.controller, @required this.focus});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
        ),
        child: TextField(
          controller: controller,
          focusNode: focus,
          decoration: InputDecoration(
            hintText: "Insira um produto",
            hintStyle: TextStyle(),
            border: InputBorder.none,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
