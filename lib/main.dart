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
            key: key); //const innebär att vi vet värdet och att det inte ändras
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
        actions: [
          PopupMenuButton(
              onSelected: (int value) {
                Provider.of<TodoList>(context, listen: false)
                    .setFilterBy(value);
              },
              itemBuilder: (context) => [
                    const PopupMenuItem(child: Text('Alla'), value: 1),
                    const PopupMenuItem(child: Text('Färdiga'), value: 2),
                    const PopupMenuItem(child: Text('Inte färdiga'), value: 3),
                  ]),
        ],
      ),
      body: Consumer<TodoList>(
          builder: (context, state, child) =>
              _field(_filterList(state.list, state.filterBy))),
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

  List<TodoBox> _filterList(list, value) {
    // definiera filterlist, gör den privat
    if (value == 1) return list;
    if (value == 2) {
      return list.where((box) => box.done == true).toList();
    }
    if (value == 3) {
      return list.where((box) => box.done == false).toList();
    }
    return list;
  }

  Widget _field(title) {
    return ListView.builder(
        itemBuilder: (context, index) => _CheckBox(title[index]),
        itemCount: title.length);
  }

  Widget _CheckBox(TodoBox checkbox) {
    var state = Provider.of<TodoList>(context, listen: false);
    return CheckboxListTile(
        activeColor: Colors.blue,
        title: Text(
          checkbox.title!,
          style: TextStyle(
            fontSize: 20,
            decoration: checkbox.done ? TextDecoration.lineThrough : null,
          ),
        ),
        secondary: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              state.DeleteTodoBox(checkbox);
            }),
        controlAffinity: ListTileControlAffinity.leading,
        value: checkbox.done,
        onChanged: (value) {
          state.done(checkbox);
        });
  }
}
