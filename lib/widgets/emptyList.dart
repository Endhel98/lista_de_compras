import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(115.0),
        children: <Widget>[
          Icon(
            Icons.shopping_cart,
            size: 50.0,
            color: Colors.white,
          ),
          Text(
            "Carrinho vazio :(",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
