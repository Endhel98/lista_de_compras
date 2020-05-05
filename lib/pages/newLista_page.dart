import 'package:flutter/material.dart';
import 'package:lista_de_compras/functionsJson/functions.dart';

class NewListPage extends StatefulWidget {
  final List listOfLists;

  NewListPage({this.listOfLists});

  @override
  _NewListPageState createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  List<Map> _shopping_cart = List();
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

  final _productController = TextEditingController();
  final _listNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
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
                  controller: _listNameController,
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
      body: Column(
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
                      _addProduct();
                      _productController.text = "";
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 100,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 60, right: 60, bottom: 70),
                child: ListView.builder(
                  itemBuilder: buildItem,
                  itemCount: _shopping_cart.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addProduct() {
    Map product = {};
    product["product"] = _productController.text;
    product["checked"] = false;
    _shopping_cart.add(product);
  }

  void _addToDO() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["name"] = _listNameController.text;
      newToDo["list"] = _shopping_cart;
      widget.listOfLists.add(newToDo);
      saveData(widget.listOfLists);
    });
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
          _lastRemoved = Map.from(_shopping_cart[index]);
          _lastRemovedPos = index;
          _shopping_cart.removeAt(index);

          final snack = SnackBar(
            content: Text("Produto \"${_lastRemoved['product']}\" removido!"),
            action: SnackBarAction(
              label: "Desfazer",
              textColor: Colors.pink,
              onPressed: () {
                setState(() {
                  _shopping_cart.insert(_lastRemovedPos, _lastRemoved);
                });
              },
            ),
            duration: Duration(seconds: 2),
          );

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
          value: _shopping_cart[index]["checked"],
          onChanged: (_) {
            setState(() {
              _shopping_cart[index]["checked"] = !_list[index]["checked"];
            });
          },
          title: Container(
            width: 100,
            child: Text(
              _shopping_cart[index]["product"],
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
