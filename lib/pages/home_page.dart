import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lista_de_compras/functionsJson/functions.dart';
import 'package:lista_de_compras/pages/add_page.dart';
import 'package:lista_de_compras/widgets/emptyList.dart';
import 'package:flutter/services.dart';
import 'package:lista_de_compras/widgets/productName.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List _shoppingCart = List();
  final _focusNode = FocusNode();

  double _totalPrices;

  @override
  void initState() {
    super.initState();

    readData().then((data) {
      setState(() {
        _shoppingCart = json.decode(data);
      });
    });

    changeStatusBar();
  }

  void changeStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.pink[300],
    ));
  }

  void _addTotalPrices() {
    _totalPrices = 0.00;
    for (Map i in _shoppingCart) {
      _totalPrices += i['price'];
    }
  }

  @override
  Widget build(BuildContext context) {
    _addTotalPrices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[600],
        elevation: 0,
        title: Text(
          "Lista de Compras",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.remove_shopping_cart,
              color: Colors.white,
            ),
            onPressed: _shoppingCart.isEmpty
                ? null
                : () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              "Compra realizada!",
                              style: TextStyle(
                                color: Colors.pink[400],
                              ),
                            ),
                          ),
                          content: Text(
                              "Tem certeza que deseja limpar a Lista de Compras?"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancelar"),
                            ),
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  _shoppingCart.clear();
                                  saveData(_shoppingCart);
                                });
                                Navigator.pop(context);
                              },
                              child: Text("Sim"),
                            )
                          ],
                        );
                      },
                    );
                    _focusNode.unfocus();
                  },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.pink[600],
              Colors.pink[500],
              Colors.pink[300],
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Colors.pink[300],
              ),
              child: FlatButton(
                child: Text(
                  "Adicionar Produto",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: _showAddPage,
              ),
            ),
            _shoppingCart.isEmpty
                ? EmptyList()
                : Expanded(
                    child: ListView.builder(
                      padding:
                          EdgeInsets.only(bottom: 100, left: 20, right: 20),
                      itemBuilder: buildItem,
                      itemCount: _shoppingCart.length,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Total: R\$$_totalPrices",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItem(context, int index) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Colors.white,
      ),
      child: CheckboxListTile(
        activeColor: Colors.lightGreen,
        checkColor: Colors.white,
        dense: true,
        controlAffinity: ListTileControlAffinity.leading,
        value: _shoppingCart[index]["checked"],
        onChanged: (_) {
          setState(() {
            _shoppingCart[index]["checked"] = !_shoppingCart[index]["checked"];
            saveData(_shoppingCart);
          });
        },
        title: SizedBox(
            width: 80,
            child: ProductName(product: _shoppingCart[index]["product"])),
        subtitle: Text(
          "R\$ ${_shoppingCart[index]["price"]}",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
        secondary: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.white,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              color: Colors.white,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Center(
                        child: Text(
                          "Remover Produto!",
                          style: TextStyle(
                            color: Colors.pink[400],
                          ),
                        ),
                      ),
                      content: Text(
                        "Tem certeza que deseja remover o produto \"${_shoppingCart[index]["product"]}\"?",
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
                            setState(() {
                              _shoppingCart.removeAt(index);
                              saveData(_shoppingCart);
                            });
                            Navigator.pop(context);
                          },
                          child: Text("Sim"),
                        )
                      ],
                    );
                  },
                );
                _focusNode.unfocus();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddPage() async {
    List recList = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddPage(
        shoppingCart: _shoppingCart,
      ),
    ));
    if (recList != null)
      setState(() {
        _shoppingCart = recList;
      });
  }
}
