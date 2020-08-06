import 'package:flutter/material.dart';

class PrefixWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13.0, left: 12.0),
      child: Text(
        "Preço: R\$",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
