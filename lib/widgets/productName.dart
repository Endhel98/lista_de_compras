import 'package:flutter/material.dart';

class ProductName extends StatelessWidget {
  final String product;
  ProductName({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Text(
        product,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
