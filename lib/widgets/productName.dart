import 'package:flutter/material.dart';

class ProductName extends StatelessWidget {
  final String productName;
  ProductName({@required this.productName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Text(
        productName,
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
    );
  }
}
