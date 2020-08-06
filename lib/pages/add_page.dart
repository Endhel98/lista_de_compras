import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:lista_de_compras/functionsJson/functions.dart';

class AddPage extends StatefulWidget {
  final List shoppingCart;
  final int index;

  AddPage({@required this.shoppingCart, this.index});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final MoneyMaskedTextController _priceController =
      MoneyMaskedTextController();

  final _productController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _isNotEditingAProduct = -1;

  @override
  void initState() {
    super.initState();

    if (widget.index != _isNotEditingAProduct) {
      _productController.text = widget.shoppingCart[widget.index]['product'];
      _priceController.updateValue(widget.shoppingCart[widget.index]['price']);
    }
  }

  void _addProduct() {
    Map<String, dynamic> product = {};
    product["product"] = _productController.text;
    product["price"] = _priceController.numberValue;
    if (widget.index != _isNotEditingAProduct) {
      product["checked"] = widget.shoppingCart[widget.index]['checked'];
      widget.shoppingCart[widget.index] = product;
    } else {
      product["checked"] = false;
      widget.shoppingCart.add(product);
    }
    saveData(widget.shoppingCart);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[600],
        elevation: 0.0,
        title: Text(
          "Lista de Compras",
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
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
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            children: <Widget>[
              SizedBox(height: 50.0),
              TextFormField(
                controller: _productController,
                validator: (text) {
                  if (text.isEmpty) return "Insira o nome do produto!";
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink[300],
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink[300],
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink[300],
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink[300],
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink[300],
                    ),
                  ),
                  errorStyle: TextStyle(color: Colors.grey[300]),
                  fillColor: Colors.pink[300],
                  filled: true,
                  hintText: "Nome do Produto",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink[300],
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink[300],
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink[300],
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink[300],
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink[300],
                    ),
                  ),
                  errorStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.pink[300],
                  filled: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 13.0, left: 12.0),
                    child: Text(
                      "Preço: R\$",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Opcional",
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 12.0,
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.0),
                  color: Colors.pink[300].withAlpha(200),
                ),
                child: FlatButton(
                  child: Text(
                    "Salvar",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _addProduct();
                      Navigator.pop(context, widget.shoppingCart);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
