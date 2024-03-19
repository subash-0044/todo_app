import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_database.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/widgets/add_todo_dialog_box.dart';

import '../widgets/todo_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List> TODOList = [
    ['Learn dart', 'dhkjclkd', false],
    ['Practise dart', 'fljkfes', false],
    ['Learn flutter', 'f;l', false],
    ['Create whatsapp', 'fmlkw', false],
  ];

  // Handle checkbox onChanged
  void onChanged(bool? value, int index) {
    context.read<ToDoDatabase>().updateTodoItem(index, value!);
  }

  TextEditingController textController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ToDoDatabase>().getAllTodoItems();
  }

  // Create new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return TodoDialog(
            onPressed: () {
              context.read<ToDoDatabase>().insertTodoItem(textController.text);
              // textController.clear();
              // descriptionController.clear();
              Navigator.pop(context);
            },
            descriptionController: descriptionController,
            titleController: textController,
          );
        });
  }

  // Delete item
  void deleteItem(int index) {
    context.read<ToDoDatabase>().removeTodoItem(index);
  }

  @override
  Widget build(BuildContext context) {
    final todoDatabase = context.watch<ToDoDatabase>();

    List<TodoItem> todos = todoDatabase.todos;
    print("subash");
    print(todos);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('T0 D0'),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return TODOListTile(
            value: todos[index].isDone,
            onChanged: (value) => onChanged(value, todos[index].id),
            title: todos[index].title,
            description: "sample",
            deleteFunction: (context) => deleteItem(todos[index].id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewTask(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
