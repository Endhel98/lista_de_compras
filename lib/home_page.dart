import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lista_de_compras/functionsJson/functions.dart';
import 'package:lista_de_compras/widgets/emptyList.dart';
import 'package:lista_de_compras/widgets/inputField.dart';
import 'package:flutter/services.dart';
import 'package:lista_de_compras/widgets/productName.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _productController = TextEditingController();
  List _shoppingCart = List();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  void clealField() {
    _productController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
            colors: [
              Colors.pink[600],
              Colors.pink[500],
              Colors.pink[300],
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 150),
                child: InputField(
                  controller: _productController,
                  focus: _focusNode,
                  shoppingCart: _shoppingCart,
                  function: () {
                    if (_formKey.currentState.validate())
                      setState(() {
                        _addProduct();
                        WidgetsBinding.instance.addPostFrameCallback(
                            (_) => _productController.clear());
                      });
                  },
                ),
              ),
              _shoppingCart.isEmpty
                  ? EmptyList()
                  : Expanded(
                      child: SizedBox(
                        height: 100,
                        child: ListView.builder(
                          padding:
                              EdgeInsets.only(top: 20, left: 50, right: 50),
                          itemBuilder: buildItem,
                          itemCount: _shoppingCart.length,
                        ),
                      ),
                    ),
            ],
          ),
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
        title: ProductName(product: _shoppingCart[index]["product"]),
        secondary: IconButton(
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
