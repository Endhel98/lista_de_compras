import 'package:flutter/material.dart';
import 'package:lista_de_compras/functionsJson/functions.dart';
import 'package:lista_de_compras/pages/newLista_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  final _productController = TextEditingController();
  //final _listNameController = TextEditingController();

  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;
  bool _isSearching = false;

  void _filterList(String value) {
    setState(() {
      newList = shoppingCart
          .where((aux) => aux["name"]
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
    shoppingCart.add(product);
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
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
                style: TextStyle(fontSize: 18),
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
                      },
                    );
                  },
                ),
        ],
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
                        _isSearching ? newList.length : shoppingCart.length,
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
          value: _isSearching
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
              _isSearching
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
