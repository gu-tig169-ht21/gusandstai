import 'package:flutter/material.dart';
import './SecondView.dart';
import 'package:provider/provider.dart';
import './model.dart';
import 'package:http/http.dart' as http; //as = namespace

void main() {
  var state = TodoList();
  state.getList();

  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: MyApp(),
    ),
  );
}

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
  const MainView({Key? key})
      : super(
            key:
                key); // vet ej vad detta är, vet att const innebär att vi vet värdet och att det inte ändras
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
          actions: []), //ska lägga till filtrering sen
      body: Consumer<TodoList>(
          builder: (context, state, child) => _field((state.list))),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_task_rounded),
        backgroundColor: Colors.blue,
        onPressed: () async {
          var newTodo = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondView(TodoBox(title: '', done: false)),
            ),
          );
          if (newTodo != null) {
            Provider.of<TodoList>(context, listen: false).addTodoBox(newTodo);
          }
        },
      ),
    );
  }

  Widget _field(title) {
    return ListView.builder(
        itemBuilder: (context, index) => _CheckBox(title[index]),
        itemCount: title.length);
  }

  Widget _CheckBox(TodoBox checkbox) {
    return CheckboxListTile(
      value: checkbox.done,
      activeColor: Colors.blue,
      title: Text(
        checkbox.title!,
        style: TextStyle(
          fontSize: 20,
          decoration: checkbox.done ? TextDecoration.lineThrough : null,
        ),
      ),
      onChanged: (value) => setState(() => checkbox.done = value!),
      secondary: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            var state = Provider.of<TodoList>(context, listen: false);
            state.DeleteTodoBox(checkbox);
          }),
    );
  }
}
