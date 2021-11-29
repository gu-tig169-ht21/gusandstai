import 'package:flutter/material.dart';

class TodoBox {
  String TodoText;
  bool true_false;
  TodoBox(this.TodoText, this.true_false);
}


class TodoList with ChangeNotifier {
  final List<TodoBox> _list = [];
  List<TodoBox> get list {
    return _list;
  }


void DeleteTodoBox(TodoBox title) {
    _list.remove(title);
    notifyListeners();
  }

  void addTodoBox(TodoBox title) {
    _list.add(title);
    notifyListeners();
  }
}
