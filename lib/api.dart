import 'dart:convert';
import './model.dart';
import 'package:http/http.dart' as http; //as = namespace

const API_KEY = '7621f30b-468a-4969-89a5-57b6dd847eba';
const API_URL = 'https://todoapp-api-pyq5q.ondigitalocean.app';

class Api {
  static Future<List<TodoBox>> addBox(TodoBox box) async {
    //print(box.title);
    Map<String, dynamic> json = TodoBox.toJson(box);
    var bodyString = jsonEncode(json);
    //print(bodyString);
    var response = await http.post(
      Uri.parse('$API_URL/todos?key=$API_KEY'),
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
    );
    bodyString = response.body;

    var list = jsonDecode(bodyString);
    //print(list);
    return list.map<TodoBox>((data) {
      return TodoBox.fromJson(data);
    }).toList(); //samlar alla elementen i den här strömmen i en List
  }

  static Future removeBox(String boxId) async {
    var response = await http
        .delete(Uri.parse('$API_URL/todos/$boxId?key=$API_KEY&_confirm=true'));
    var bodyString = response.body;
    var list = jsonDecode(bodyString);

    return list.map<TodoBox>((data) {
      return TodoBox.fromJson(data);
    }).toList();
  }

  static Future putBoxApi(TodoBox box) async {
    Map<String, dynamic> json = TodoBox.toJson(box);
    var bodyString = jsonEncode(json);
    var boxId = box.id;
    // print(bodyString);
    var response = await http.put(
      Uri.parse('$API_URL/todos/$boxId?key=$API_KEY'),
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
    );
    bodyString = response.body;
    var list = jsonDecode(bodyString);
    print(bodyString);
    return list.map<TodoBox>((data) {
      return TodoBox.fromJson(data);
    }).toList();
  }

  static Future<List<TodoBox>> getBox() async {
    var response = await http.get(Uri.parse('$API_URL/todos?key=$API_KEY'),
        headers: {'Content-Type': 'application/json'});

    var bodyString = response.body;
    print(bodyString);
    var json = jsonDecode(bodyString);
    return json.map<TodoBox>((data) {
      return TodoBox.fromJson(data);
    }).toList();
  }
}
