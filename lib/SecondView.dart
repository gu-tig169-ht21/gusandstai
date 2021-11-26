import 'package:flutter/material.dart';
import './model.dart';

class SecondView extends StatefulWidget {
  final TodoBox checkbox;

  SecondView(this.checkbox);

  @override
  State<StatefulWidget> createState() {
    return _SecondViewState(checkbox);
  }
}

class _SecondViewState extends State<SecondView> {
  //hade problem med null värden, late gör att den inte körs förens den är kallad vilket gör att den inte blir null
  late String TodoText;
  late TextEditingController textEditingController;

  _SecondViewState(TodoBox box) {
    this.TodoText = box.TodoText;

    textEditingController = TextEditingController();

    textEditingController.addListener(() {
      setState(() {
        TodoText = textEditingController.text;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TIG169 TODO",
        ),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Vad ska du göra'),
              controller: textEditingController,
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 16,
                  right:
                      16), //den verkar inte göra sitt jobb längre men får det inte att funka utan den...
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: const Text('Add'),
                onPressed: () {
                  Navigator.pop(
                      context,
                      TodoBox(
                        TodoText: TodoText,
                      )); // textEditingController.text, false
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
