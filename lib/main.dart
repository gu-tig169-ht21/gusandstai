import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TIG169 TODO'),
        actions: [
          IconButton(
              icon: Icon(Icons
                  .arrow_right_alt_rounded), //knappen är gömd bakim "debug" men den funkar
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondView()),
                );
              }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _checkboxRow(),
            _add(),
            _box(),
          ],
        ),
      ),
    );
  }

  Widget _appbar() {
    return Container(
        height: 58,
        decoration: BoxDecoration(color: Colors.blue),
        child: Center());
  }
}

Widget _checkboxRow() {
  return Row(
    children: [
      Checkbox(
        value: false,
        onChanged: (val) {},
      ),
      Text('Tvätta'),
      Icon(Icons.delete),
    ],
  );
}

Widget _add() {
  return Row(
    children: [
      Checkbox(
        value: true,
        onChanged: (val) {},
      ),
      Text('Diska', style: TextStyle(decoration: TextDecoration.lineThrough)),
      Icon(Icons.delete),
    ],
  );
}

Widget _box() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.add_box_rounded,
        size: 50,
      ),
    ],
  );
}

class SecondView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _field(),
    );
  }
}

Widget _field() {
  return ListView(
    children: [
      Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: TextField(
          decoration: InputDecoration(hintText: 'Vad ska du göra'),
        ),
      ),
      Container(height: 24), //flytta på addknappen
      _plusbox(),
    ],
  );
}

Widget _plusbox() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center, //lägger till knappen i mitten
    children: [
      Icon(
        Icons.add,
        size: 12,
      ),
      Text('Add'),
    ],
  );
}
