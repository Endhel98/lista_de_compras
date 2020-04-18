import 'package:flutter/material.dart';
import 'package:lista_de_compras/pages/newLista_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _seachController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.pink[400],
                Colors.pink[300],
                Colors.pink[200],
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              !_isSearching
                  ? Padding(
                      padding: EdgeInsets.only(top: 30, left: 30, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "Lista de Compras",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          ),
                          IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                _isSearching = !_isSearching;
                              });
                            },
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: 30, left: 10, bottom: 30),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: _seachController,
                              autofocus: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                hintText: "Insira o nome da Lista",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.grey),
                              ),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          IconButton(
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
                      ),
                    ),
              TabBar(
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
              Expanded(
                  child: TabBarView(children: <Widget>[
                NewListPage(),
                Text(""),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
