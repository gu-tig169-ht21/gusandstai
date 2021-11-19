import 'package:flutter/material.dart';
import './SecondView.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  //göra om till en statefulwidget
  const MainView({Key? key}) : super(key: key); // vet ej vad detta är
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<String> _TodoBox = <String>[];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TIG169 TODO'),
      ),
      body: ListView(
        children: [],
      ), //fluttade knappen till body istället samma som figma
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_task_rounded),
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondView()),
              )),
    );
  }
}

class Todobox {
  String todo;
  Todobox({
    required this.todo,
  });
}
