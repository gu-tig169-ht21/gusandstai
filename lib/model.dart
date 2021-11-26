import 'package:flutter/material.dart';
import './api.dart';

class TodoBox {
  String id;
  String TodoText;
  bool true_false;

  TodoBox(
      {this.id = '',
      required this.TodoText,
      this.true_false =
          false}); //igen problem med null värden, todotext får inte vara null

  void toggleDone(TodoBox activity) {
    true_false = !true_false;
  }

  static Map<String, dynamic> toJson(TodoBox activity) {
    return {
      'TodoText': activity.TodoText,
      'true_false': (activity.true_false),
    };
  }

  static TodoBox fromJson(Map<String, dynamic> json) {
    return TodoBox(
        id: json['id'],
        TodoText: json['TodoText'],
        true_false: json['true_false']);
  }
}

class TodoList extends ChangeNotifier {
  List<TodoBox> _list = [];
  List<TodoBox> get list {
    return _list;
  }

//lägga till en massa async funktioner
  Future getList() async {
    List<TodoBox> list = await Api.getBox();
    _list = list;
    notifyListeners();
  }

  void DeleteTodoBox(TodoBox box) async {
    _list = await Api.removeBox(box.id);
    notifyListeners();
  }

  void addTodoBox(TodoBox box) async {
    _list = await Api.addBox(box);
    notifyListeners();
  }
}
