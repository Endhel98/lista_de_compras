import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lista_de_compras/functionsJson/functions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  final _productController = TextEditingController();

  List _shoppingCart = List();
  List _newShoppingCart = List();

  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    readData().then((data) {
      setState(() {
        _shoppingCart = json.decode(data);
        _newShoppingCart = _shoppingCart;
      });
    });
  }

  void _filterList(String value) {
    setState(() {
      _newShoppingCart = _shoppingCart
          .where((aux) => aux["product"]
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  void _addProduct() {
    Map product = {};
    product["product"] = _productController.text;
    product["checked"] = false;
    _shoppingCart.add(product);
    saveData(_shoppingCart);
    _newShoppingCart = _shoppingCart;
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
                  hintText: "Insira o nome do produto",
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: _filterList,
              ),
        actions: <Widget>[
          !_isSearching
              ? IconButton(
                  padding: EdgeInsets.only(right: 5),
                  icon: Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () {
                    setState(
                      () {
                        _isSearching = !_isSearching;
                      },
                    );
                  },
                )
              : IconButton(
                  padding: EdgeInsets.only(right: 5),
                  icon: Icon(Icons.cancel),
                  color: Colors.white,
                  onPressed: () {
                    setState(
                      () {
                        _isSearching = !_isSearching;
                        _searchController.clear();
                        _newShoppingCart = _shoppingCart;
                      },
                    );
                  },
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                content:
                    Text("Tem certeza que deseja limpar a Lista de Compras?"),
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
                        _newShoppingCart.clear();
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
        },
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.check_circle,
          size: 50,
        ),
        elevation: 0,
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
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(32),
                        color: Colors.white,
                      ),
                      child: TextField(
                        onTap: () {
                          setState(() {
                            _isSearching = false;
                          });
                        },
                        controller: _productController,
                        decoration: InputDecoration(
                          hintText: "Insira um produto",
                          hintStyle: TextStyle(),
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {
                      setState(() {
                        _addProduct();
                        _productController.text = "";
                      });
                    },
                  ),
                ],
              ),
            ),
            _newShoppingCart.isEmpty
                ? Expanded(
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 80),
                      children: <Widget>[
                        Icon(
                          Icons.shopping_cart,
                          size: 50,
                          color: Colors.white,
                        ),
                        Text(
                          "Carrinho vazio :(",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 20, left: 60, right: 60, bottom: 5),
                        child: ListView.builder(
                          itemBuilder: buildItem,
                          itemCount: _newShoppingCart.length,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(context, index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment(0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      onDismissed: (_) {
        setState(() {
          _lastRemoved = Map.from(_newShoppingCart[index]);
          _lastRemovedPos = index;
          _shoppingCart.removeAt(index);
          _newShoppingCart = _shoppingCart;

          final snack = SnackBar(
            content: Text("Produto \"${_lastRemoved['product']}\" removido!"),
            action: SnackBarAction(
              label: "Desfazer",
              textColor: Colors.pink,
              onPressed: () {
                setState(() {
                  _shoppingCart.insert(_lastRemovedPos, _lastRemoved);
                  _newShoppingCart = _shoppingCart;
                });
              },
            ),
            duration: Duration(seconds: 2),
          );

          saveData(_shoppingCart);

          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snack);
        });
      },
      child: Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.white,
        ),
        child: CheckboxListTile(
          checkColor: Colors.lightGreen,
          activeColor: Colors.white,
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          value: _newShoppingCart[index]["checked"],
          onChanged: (_) {
            setState(() {
              _newShoppingCart[index]["checked"] =
                  !_newShoppingCart[index]["checked"];
            });
          },
          title: Container(
            width: 100,
            child: Text(
              _newShoppingCart[index]["product"],
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
