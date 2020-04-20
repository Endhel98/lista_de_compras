import 'package:flutter/material.dart';
import 'package:lista_de_compras/pages/lists_page.dart';
import 'package:lista_de_compras/pages/newLista_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        //extendBodyBehindAppBar: true,
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
                      IconButton(
                        icon: Icon(Icons.more_vert),
                        color: Colors.white,
                        onPressed: () {},
                      )
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
            children: <Widget>[
              NewListPage(),
              ListsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
