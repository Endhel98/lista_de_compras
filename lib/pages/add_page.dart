import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddPage extends StatelessWidget {
  final MoneyMaskedTextController _priceController =
      MoneyMaskedTextController();
  final _productController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  errorStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.pink[300],
                  filled: true,
                  hintText: "Nome do Produto",
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _priceController,
                validator: (_) {
                  if (_priceController.numberValue == 0)
                    return "Insira o preço do produto!";
                  return null;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorStyle: TextStyle(color: Colors.white),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 13.0),
                    child: Text(
                      "Preço: R\$",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 35.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.pink[300],
                ),
                child: FlatButton(
                  child: Text(
                    "Salvar",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {}
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

// Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.only(top: 150),
//                 child: InputField(
//                   controller: _productController,
//                   focus: _focusNode,
//                   shoppingCart: _shoppingCart,
//                   function: () {
//                     if (_formKey.currentState.validate())
//                       setState(() {
//                         _addProduct();
//                         WidgetsBinding.instance.addPostFrameCallback(
//                             (_) => _productController.clear());
//                       });
//                   },
//                 ),
//               ),
