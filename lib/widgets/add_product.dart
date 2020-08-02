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
