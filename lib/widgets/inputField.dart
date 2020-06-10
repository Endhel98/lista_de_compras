import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final List shoppingCart;
  final Function function;

  InputField({
    @required this.controller,
    @required this.focus,
    @required this.shoppingCart,
    @required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 35, right: 35),
      child: TextFormField(
        controller: controller,
        focusNode: focus,
        validator: (value) {
          if (value.isEmpty) {
            return "Insira um produto!";
          } else if (checksRepeatedProduct(value)) {
            return "Este produto já está na lista!";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Insira um produto",
          hintStyle: TextStyle(letterSpacing: 0.9),
          fillColor: Colors.white.withOpacity(0.8),
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.pink[500],
            ),
            onPressed: function,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(
              color: Colors.pink,
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: Colors.pink, width: 0),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: Colors.pink, width: 0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: Colors.pink, width: 0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: Colors.pink, width: 0),
          ),
          errorStyle: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  bool checksRepeatedProduct(String value) {
    for (Map aux in shoppingCart)
      if (aux["product"] == value) {
        return true;
      }
    return false;
  }
}
