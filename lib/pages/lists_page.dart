import 'package:flutter/material.dart';

class ListsPage extends StatelessWidget {
  final List listOfLists;

  ListsPage({this.listOfLists});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        itemCount: listOfLists.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              listOfLists[index]["name"],
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          );
        },
      ),
    );
  }
}
