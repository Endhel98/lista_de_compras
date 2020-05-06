import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lista_de_compras/functionsJson/functions.dart';
import 'package:lista_de_compras/pages/lists_page.dart';
import 'package:lista_de_compras/pages/newLista_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  bool _isSearching = false;
  List _list = [];
  TabController controller;

  void _filterList(String value) {
    setState(() {
      newList = shoppingCart
          .where((aux) => aux["name"]
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2);
    readData().then((data) {
      setState(() {
        _list = json.decode(data);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        elevation: 0,
        title: !_isSearching
            ? Text(
                "Lista de Compras",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            : TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: "Insira o nome da Lista",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
                style: TextStyle(fontSize: 18),
                onChanged: _filterList,
              ),
        actions: <Widget>[
          !_isSearching
              ? Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.white,
                      onPressed: () {
                        setState(
                          () {
                            _isSearching = !_isSearching;
                          },
                        );
                      },
                    ),
                  ],
                )
              : IconButton(
                  icon: Icon(Icons.cancel),
                  color: Colors.white,
                  onPressed: () {
                    setState(
                      () {
                        _isSearching = !_isSearching;
                      },
                    );
                  },
                ),
        ],
        bottom: TabBar(
          controller: controller,
          isScrollable: true,
          labelPadding: EdgeInsets.symmetric(horizontal: 50.0),
          tabs: <Widget>[
            Tab(
              child: Text(
                "Criar Lista",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Tab(
              child: Text(
                "Listas",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            colors: [
              Colors.pink[400],
              Colors.pink[300],
              Colors.pink[200],
            ],
          ),
        ),
        child: TabBarView(
          controller: controller,
          children: <Widget>[
            NewListPage(
              list: _list,
              isSearching: _isSearching,
            ),
            ListsPage(
              list: _list,
              //controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}
