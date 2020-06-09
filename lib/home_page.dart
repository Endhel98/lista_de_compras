import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lista_de_compras/functionsJson/functions.dart';
import 'package:lista_de_compras/widgets/emptyList.dart';
import 'package:lista_de_compras/widgets/inputField.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _productController = TextEditingController();

  List _shoppingCart = List();

  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    changeStatusBar();

    readData().then((data) {
      setState(() {
        _shoppingCart = json.decode(data);
      });
    });
  }

  void changeStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.pink[300],
    ));
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
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "OK",
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Lista de Compras",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
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
                _focusNode.unfocus();
              },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.delete,
          size: 30,
          color: Colors.pink[300],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.pink[600],
              Colors.pink[500],
              Colors.pink[300],
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 150, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InputField(controller: _productController, focus: _focusNode),
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
                    },
                  ),
                ],
              ),
            ),
            _shoppingCart.isEmpty
                ? EmptyList()
                : Expanded(
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
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
        activeColor: Colors.lightGreen,
        checkColor: Colors.white,
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
                      "Tem certeza que deseja remover o produto \"${_shoppingCart[index]["product"]}\"?"),
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
      ),
    );
  }
}
