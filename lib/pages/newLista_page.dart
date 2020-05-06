import 'package:flutter/material.dart';
import 'package:lista_de_compras/functionsJson/functions.dart';

List<Map> shoppingCart = List();

class NewListPage extends StatefulWidget {
  final List list;
  final bool isSearching;

  NewListPage({this.list, this.isSearching});

  @override
  _NewListPageState createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.isSearching
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Center(
                        child: Text(
                          "Salvando a Lista",
                          style: TextStyle(
                            color: Colors.pink[400],
                          ),
                        ),
                      ),
                      content: TextField(
                        //controller: _listNameController,
                        decoration: InputDecoration(
                          hintText: "Insira o nome da Lista",
                          hintStyle: TextStyle(),
                          border: InputBorder.none,
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancelar"),
                        ),
                        FlatButton(
                          onPressed: () {
                            _addToDO();
                            Navigator.pop(context);
                          },
                          child: Text("Salvar"),
                        )
                      ],
                    );
                  },
                );
              },
              elevation: 0,
              label: Text(
                "Salvar Lista",
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
              ),
              backgroundColor: Colors.pink[400],
            ),
    );
  }

  void _addToDO() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      //newToDo["name"] = _listNameController.text;
      newToDo["list"] = shoppingCart;
      widget.list.add(newToDo);
      saveData(widget.list);
    });
  }
}
