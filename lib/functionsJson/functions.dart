import 'dart:convert';
import 'dart:io';
import 'package:lista_de_compras/pages/newLista_page.dart';
import 'package:path_provider/path_provider.dart';

List<Map> newList = List.from(shoppingCart);

Future<File> getFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File("${directory.path}/data.json");
}

Future<String> readData() async {
  try {
    final file = await getFile();
    return file.readAsString();
  } catch (e) {
    return null;
  }
}

Future<File> saveData(List list) async {
  String data = json.encode(list);
  final file = await getFile();
  return file.writeAsString(data);
}
