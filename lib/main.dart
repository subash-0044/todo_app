import 'package:flutter/material.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/widgets/todo_list_tile.dart';
import 'package:provider/provider.dart';

import 'models/todo_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ToDoDatabase.initialise();
  runApp(ChangeNotifierProvider(
    create: (context) => ToDoDatabase(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TO DO',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: HomePage(),
    );
  }
}
