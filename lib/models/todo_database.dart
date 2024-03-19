import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'todo_item.dart';

class ToDoDatabase extends ChangeNotifier {
  static late Isar _isar;
  final List<TodoItem> todos = [];

  static Future<void> initialise() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [TodoItemSchema],
      directory: dir.path,
    );
  }

  Future<void> insertTodoItem(String title) async {
    final newTodo = TodoItem()
      ..title = title
      ..isDone = false;

    await _isar.writeTxn(() async {
      await _isar.todoItems.put(newTodo); // insert & update
    });
    getAllTodoItems();
  }

  Future<void> getAllTodoItems() async {
    final allTodos = await _isar.todoItems.where().findAll();
    todos.clear();
    todos.addAll(allTodos);
    print("subash is checking");
    print(todos);
    notifyListeners();
  }

  Future<void> removeTodoItem(int id) async {
    await _isar.writeTxn(() async {
      await _isar.todoItems.delete(id);
    });
    getAllTodoItems();
  }

  Future<void> updateTodoItem(int id, bool isDone) async {
    final todo = await _isar.todoItems.get(id);
    await _isar.writeTxn(() async {
      todo!.isDone = isDone;
      await _isar.todoItems.put(todo);
    });
    getAllTodoItems();
  }
}
