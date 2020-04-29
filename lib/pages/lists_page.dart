import 'package:flutter/material.dart';
import 'package:lista_de_compras/functionsJson/functions.dart';

class ListsPage extends StatefulWidget {
  final List listOfLists;

  ListsPage({this.listOfLists});

  @override
  _ListsPageState createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  List _list = [];

  @override
  void initState() {
    super.initState();
    _list = widget.listOfLists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                _list[index]["name"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              dense: true,
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _removeList(index);
                  });
                },
              ),
            );
          },
          separatorBuilder: (_, __) {
            return Divider();
          },
        ),
      ),
    );
  }

  void _removeList(index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Tem certeza que deseja excluir a lista?"),
          content: Text("Se sim, a lista será excluída permanentemente!"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Sim"),
              onPressed: () {
                widget.listOfLists.removeAt(index);
                saveData(widget.listOfLists);
                _getAllLists();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _getAllLists() {
    setState(() {
      _list = widget.listOfLists;
    });
  }
}
