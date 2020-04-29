import 'package:flutter/material.dart';

class ListsPage extends StatefulWidget {
  final List listOfLists;

  ListsPage({this.listOfLists});

  @override
  _ListsPageState createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
          itemCount: widget.listOfLists.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                widget.listOfLists[index]["name"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              dense: true,
            );
          },
          separatorBuilder: (_, __) {
            return Divider();
          },
        ),
      ),
    );
  }
}
