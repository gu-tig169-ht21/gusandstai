import 'package:flutter/material.dart';

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