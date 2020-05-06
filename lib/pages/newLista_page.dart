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
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

  final _productController = TextEditingController();
  final _listNameController = TextEditingController();

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
                  itemCount:
                      widget.isSearching ? newList.length : shoppingCart.length,
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
    shoppingCart.add(product);
  }

  void _addToDO() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["name"] = _listNameController.text;
      newToDo["list"] = shoppingCart;
      widget.list.add(newToDo);
      saveData(widget.list);
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
          _lastRemoved = Map.from(shoppingCart[index]);
          _lastRemovedPos = index;
          shoppingCart.removeAt(index);

          final snack = SnackBar(
            content: Text("Produto \"${_lastRemoved['product']}\" removido!"),
            action: SnackBarAction(
              label: "Desfazer",
              textColor: Colors.pink,
              onPressed: () {
                setState(() {
                  shoppingCart.insert(_lastRemovedPos, _lastRemoved);
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
          value: widget.isSearching
              ? newList[index]["checked"]
              : shoppingCart[index]["checked"],
          onChanged: (_) {
            setState(() {
              newList[index]["checked"] = !newList[index]["checked"];
            });
          },
          title: Container(
            width: 100,
            child: Text(
              widget.isSearching
                  ? newList[index]["product"]
                  : shoppingCart[index]["product"],
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
