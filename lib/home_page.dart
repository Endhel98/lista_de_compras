import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lista_de_compras/functionsJson/functions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _productController = TextEditingController();

  List _shoppingCart = List();

  @override
  void initState() {
    super.initState();

    readData().then((data) {
      setState(() {
        _shoppingCart = json.decode(data);
      });
    });
  }

  void _addProduct() {
    Map<String, dynamic> product = {};
    product["product"] = _productController.text;
    product["checked"] = false;
    _shoppingCart.add(product);
    saveData(_shoppingCart);
  }

  bool _checksRepeatedProduct() {
    for (Map aux in _shoppingCart)
      if (aux["product"] == _productController.text) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  "OPS!",
                  style: TextStyle(
                    color: Colors.pink[400],
                  ),
                ),
              ),
              content: Text(
                "Você já inseriu este produto!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            );
          },
        );
        _productController.clear();
        return true;
      }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        elevation: 0,
        title: Text(
          "Lista de Compras",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
                          if (_productController.text != "" &&
                              !_checksRepeatedProduct()) {
                            _addProduct();
                            _productController.text = "";
                          }
                        });
                      }),
                ],
              ),
            ),
            _shoppingCart.isEmpty
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
                            top: 20, left: 30, right: 60, bottom: 5),
                        child: ListView.builder(
                          itemBuilder: buildItem,
                          itemCount: _shoppingCart.length,
                        ),
                      ),
                    ),
                  ),
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
        checkColor: Colors.lightGreen,
        activeColor: Colors.white,
        dense: true,
        controlAffinity: ListTileControlAffinity.leading,
        value: _shoppingCart[index]["checked"],
        onChanged: (_) {
          setState(() {
            _shoppingCart[index]["checked"] = !_shoppingCart[index]["checked"];
          });
        },
        title: Container(
          width: 100,
          child: Text(
            _shoppingCart[index]["product"],
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        secondary: IconButton(
          icon: Icon(Icons.delete),
          color: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}
