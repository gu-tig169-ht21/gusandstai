import 'package:flutter/material.dart';
import './api.dart';

class TodoBox {
  String id;
  String? title; // ? = innebär att den får lov att vara null
  bool done;

  TodoBox(
      {this.id = '',
      this.title,
      this.done =
          false}); //igen problem med null värden, title får inte vara null

  void toggleDone(TodoBox box) {
    done = !done;
  }

  static Map<String, dynamic> toJson(TodoBox box) {
    return {
      'title': box.title,
      'done': (box.done),
    };
  }

  static TodoBox fromJson(Map<String, dynamic> json) {
    return TodoBox(id: json['id'], title: json['title'], done: json['done']);
  }
}

class TodoList extends ChangeNotifier {
  List<TodoBox> _list = [];
  List<TodoBox> get list => _list;
  int _filterBy = 1;
  int get filterBy => _filterBy;

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

  void done(TodoBox box) async {
    box.toggleDone(box);

    _list = await Api.putBoxApi(box);
    notifyListeners();
  }

  void setFilterBy(int filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }
}
