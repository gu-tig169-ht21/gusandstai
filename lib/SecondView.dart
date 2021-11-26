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
  late String message;
  late bool true_false;
  late TextEditingController textEditingController;

  _SecondViewState(TodoBox box) {
    this.message = box.TodoText;
    this.true_false = box.true_false;

    textEditingController = TextEditingController();

    textEditingController.addListener(() {
      setState(() {
        message = textEditingController.text;
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
                        TodoText: message,
                        true_false: true_false,
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
