import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:lista_de_compras/functionsJson/functions.dart';
import 'package:lista_de_compras/pages/prefix_widget.dart';
import 'package:lista_de_compras/widgets/input_field.dart';

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
  int _index;
  List _shoppingCart = [];

  @override
  void initState() {
    super.initState();

    _index = widget.index;
    _shoppingCart = widget.shoppingCart;

    if (_index != _isNotEditingAProduct) {
      _productController.text = _shoppingCart[_index]['product'];
      _priceController.updateValue(_shoppingCart[_index]['price']);
    }
  }

  void _addProduct() {
    Map<String, dynamic> product = {};

    product["product"] = _productController.text;
    product["price"] = _priceController.numberValue;

    if (_index != _isNotEditingAProduct) {
      product["checked"] = _shoppingCart[_index]['checked'];
      _shoppingCart[_index] = product;
    } else {
      product["checked"] = false;
      _shoppingCart.add(product);
    }

    saveData(_shoppingCart);
  }

  String _validator(text) {
    if (text.isEmpty) return "Insira o nome do produto!";
    return null;
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
              InputField(
                controller: _productController,
                hint: "Nome do Produto",
                validator: _validator,
              ),
              SizedBox(height: 20.0),
              InputField(
                controller: _priceController,
                type: TextInputType.number,
                prefix: PrefixWidget(),
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
                  borderRadius: BorderRadius.circular(15.0),
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
                      Navigator.pop(context, _shoppingCart);
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
