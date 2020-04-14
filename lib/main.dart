import 'package:flutter/material.dart';
import 'package:lista_de_compras/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.greenAccent[900],
      ),
      home: HomePage(),
    );
  }
}
