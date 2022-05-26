import 'package:flutter/material.dart';
import 'package:todo_app_project/screens/create_todo_screen.dart';

import './home.dart';
import './models/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const size = 150.0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      initialRoute: '/',
      routes: {
        '/': (ctx) => const Home(),
        CreateTodoScreen.routeName: (ctx) => const CreateTodoScreen(),
      },
    );
  }
}
