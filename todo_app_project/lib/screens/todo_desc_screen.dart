import 'package:flutter/material.dart';

import 'package:todo_app_project/screens/edit_todo_screen.dart';
import '../models/todo.dart';
import '../widgets/todo_desc.dart';

class TodoDescScreen extends StatelessWidget {
  const TodoDescScreen({Key? key}) : super(key: key);

  static const routeName = '/TodoDescScreen';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Todo;

    final todoMap = [args];
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(
              EditTodoScreen.routeName,
              arguments: args,
            ),
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: Center(
        child: TodoDesc(
          title: args.title,
          date: args.date,
          importance: args.importance,
          label: args.label,
        ),
      ),
    );
  }
}
